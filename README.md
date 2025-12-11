# crawl4ai-client-rust

[![Build](https://github.com/nurokhq/crawl4ai-client-rust/actions/workflows/build.yml/badge.svg)](https://github.com/nurokhq/crawl4ai-client-rust/actions/workflows/build.yml)
[![Rust](https://img.shields.io/badge/rust-1.85+-blue.svg)](https://www.rust-lang.org/)
[![Code style: rustfmt](https://img.shields.io/badge/code%20style-rustfmt-000000.svg)](https://github.com/rust-lang/rustfmt)
[![Linter: clippy](https://img.shields.io/badge/linter-clippy-blue.svg)](https://github.com/rust-lang/rust-clippy)

Rust API Client SDK for  [Crawl4AI API](https://github.com/unclecode/crawl4ai), providing type-safe bindings to interact with Crawl4AI.

## Overview

This client is auto-generated from `api/crawl4ai-openapi.json`. It targets teams that want a lightweight, async-first Rust interface to Crawl4AI for crawling, enrichment, and downstream LLM workflows.

## Features

- **Type-safe client** generated from Crawl4AI OpenAPI
- **Async/await** powered by `reqwest`
- **TLS options**: `rustls-tls` (default) or `native-tls`
- **Crawling + streaming**: `/crawl` and `/crawl/stream` endpoints
- **Job orchestration**: enqueue and poll crawl/LLM jobs
- **Content generation**: HTML, PDF, screenshots, markdown helpers
- **JS execution**: run site-specific JS via the API

## Installation

Add this to your `Cargo.toml`:

```toml
[dependencies]
crawl4ai-client = { version = "0.1.0", features = ["rustls-tls"] }
```

Or with native TLS:

```toml
[dependencies]
crawl4ai-client = { version = "0.1.0", features = ["native-tls"] }
```

If the crate is not yet published on crates.io, use the Git dependency:

```toml
[dependencies]
crawl4ai-client = { git = "https://github.com/nurokhq/crawl4ai-client-rust", features = ["rustls-tls"] }
```

## Version Compatibility

The client tracks the Crawl4AI OpenAPI version shipped in this repo.

| Client Version | Crawl4AI API Version |
|----------------|----------------------|
| 0.1.0          | 0.7.8               |

Please ensure you use a compatible client version for your Crawl4AI deployment.

## Usage

```rust
use crawl4ai_client::apis::{configuration::{ApiKey, Configuration}, default_api};
use crawl4ai_client::models::CrawlRequestWithHooks;

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    // Configure the client
    let mut config = Configuration::default();
    config.base_path = "https://api.crawl4ai.com".to_string(); // set to your deployment
    config.api_key = Some(ApiKey { prefix: None, key: "YOUR_API_KEY".into() });

    // Build a crawl request
    let request = CrawlRequestWithHooks::new(vec![
        "https://example.com".to_string(),
    ]);

    // Fire the crawl
    let response = default_api::crawl_crawl_post(&config, request).await?;
    println!("{response}");

    Ok(())
}
```

## Features

- `default`: Enables `rustls-tls` feature
- `rustls-tls`: Use rustls for TLS (default, recommended)
- `native-tls`: Use native TLS implementation

## Development

This SDK is generated from the OpenAPI specification using [OpenAPI Generator](https://openapi-generator.tech).

To regenerate the SDK:

```bash
./scripts/generate_api_sdk.sh
```

This script:
1. Generates the SDK from `api/crawl4ai-openapi.json`
2. Copies the generated code to `src/generated/`
3. Formats the code with `cargo fmt`

## Requirements

- Rust 1.85 or later
- OpenAPI Generator CLI (for regeneration)

## License

See [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please ensure that:
- Code is formatted with `cargo fmt`
- All tests pass with `cargo test`
- Clippy checks pass with `cargo clippy`
