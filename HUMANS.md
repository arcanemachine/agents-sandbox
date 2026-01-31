## Getting Started

When working in the container, make sure to set up the environment for this workspace:

- First, run this script from the host so the container environment has the correct Postgres IP address:

```bash
./scripts/env-generator.sh
```

Then, you can run this command in the container to initialize the environment: `source env.sh`
