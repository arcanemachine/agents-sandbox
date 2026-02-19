## Getting Started

If working with Postgres via an external Docker container, make sure to set up the environment for this workspace:

- First, run this script from the host so the container environment has the correct Postgres IP address:

```bash
./scripts/env-generator.sh
```

Now, when you run `./shell`, it will have the correct Postgres IP address.
