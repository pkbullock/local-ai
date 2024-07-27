# Overview

This repo shows how to run models locally using the AI Toolkit. The AI Toolkit is a set of tools that help you run models locally, without needing to deploy them to a server. This is useful for testing and debugging models before deploying them to a server.

AI toolkit for VSC Marketplace: https://marketplace.visualstudio.com/items?itemName=ms-windows-ai-studio.windows-ai-studio

The AI Toolkit includes the following tools:

- Model Playground: A web-based tool that lets you run models in your VS Code extension
- Model Training: A command-line tool that lets you train models on your local machine

I am using the follow models:

- Phi-3-mini-128k-cpu-int4-rtn-block-32-onnx
- Phi-3-mini-128k-directml-int4-awq-block-128-onnx

The model catalog will recommend models based on your local hardware. My laptop is relatively old so able to run more advanced models.

When downloading the models the are stored in ${HOME}\.aitk\models\microsoft\Phi-3-mini-128k-instruct-onnx...

## Cool References

- https://github.com/microsoft/semantic-kernel/blob/main/dotnet/README.md
