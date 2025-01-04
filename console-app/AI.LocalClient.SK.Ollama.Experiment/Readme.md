# Introduction

Getting a simple client working with Ollama locally using SK.

## Setup

Commands

```
dotnet new console -n dotnet new console -n AI.LocalClient.SK.Ollama.Experiment 
dotnet add package Microsoft.SemanticKernel
dotnet add package Microsoft.SemanticKernel.Connectors.Ollama --version 1.32.0-alpha
dotnet add package OpenTelemetry.Exporter.OpenTelemetryProtocol
```

## Ollama

- https://ollama.com/ 
- Download and install

Examples to run to get models:

```
ollama pull phi3.5
ollama pull gemma2:2b
ollama pull gemma2:9b

```

