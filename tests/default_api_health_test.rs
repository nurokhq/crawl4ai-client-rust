use crawl4ai_client::apis::{configuration::Configuration, default_api};
use httpmock::prelude::*;
use serde_json::json;

// Ensures the generated client hits the expected health endpoint and parses JSON.
#[tokio::test]
async fn health_endpoint_returns_ok() {
    let server = MockServer::start();

    let mock = server.mock(|when, then| {
        when.method(GET).path("/health");
        then.status(200)
            .header("content-type", "application/json")
            .json_body(json!({ "status": "ok" }));
    });

    let config = Configuration {
        base_path: server.base_url(),
        ..Configuration::default()
    };

    let response = default_api::health_health_get(&config)
        .await
        .expect("health request should succeed");

    mock.assert();
    assert_eq!(response, json!({ "status": "ok" }));
}
