import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";
import { Type } from "@sinclair/typebox";

export default function(pi: ExtensionAPI) {
  pi.registerTool({
    name: "search",
    description: "Search the web or load and extract text from a URL",
    parameters: Type.Object({
      action: Type.Union([
        Type.Literal("search"),
        Type.Literal("load"),
      ], { description: "'search' queries SearXNG, 'load' fetches a URL" }),
      input: Type.String({ description: "Search query or full URL" }),
    }),

    async execute(_toolCallId, params, _signal, onUpdate) {
      onUpdate?.({
        content: [{ type: "text", text: `${params.action === "search" ? "Searching for" : "Loading"} ${params.input}...` }],
        details: {},
      });

      if (params.action === "search") {
        const url = `${process.env.SEARXNG_URL ?? "http://127.0.0.1:8411"}/search?q=${encodeURIComponent(params.input)}&format=json&categories=general`;
        const res = await fetch(url);

        if (!res.ok) throw new Error(`SearXNG error: ${res.status} ${res.statusText}`);

        const data = await res.json();
        const results = (data.results ?? [])
          .slice(0, 5)
          .map((r: any, i: number) => `${i + 1}. ${r.title}\n   ${r.url}\n   ${r.content ?? ""}`)
          .join("\n\n");

        return {
          content: [{ type: "text", text: results || "No results found." }],
          details: { query: params.input },
        };

      } else {
        const res = await fetch(params.input, {
          headers: { "User-Agent": "Mozilla/5.0 (compatible; pi-agent/1.0)" },
        });

        if (!res.ok) throw new Error(`Failed to load page: ${res.status} ${res.statusText}`);

        const html = await res.text();
        const text = html
          .replace(/<script[^>]*>[\s\S]*?<\/script>/gi, "")
          .replace(/<style[^>]*>[\s\S]*?<\/style>/gi, "")
          .replace(/<[^>]+>/g, " ")
          .replace(/\s+/g, " ")
          .trim();

        return {
          content: [{ type: "text", text: text.slice(0, 20000) }],
          details: { url: params.input },
        };
      }
    },
  });
}
