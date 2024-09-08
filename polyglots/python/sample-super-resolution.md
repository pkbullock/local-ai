# Running Super Resolution Example

```bash
pip install onnx onnxruntime onnxruntime-qnn
pip install "qai_hub_models[quicksrnetlarge_quantized]"


python -m qai_hub_models.models.quicksrnetlarge.demo --on-device
```


```python
import onnx
import onnxruntime as ort
import numpy as np

# Load the ONNX model
model_path = "quicksrnetlarge_quantized.onnx"
session = ort.InferenceSession(model_path, providers=['QNNExecutionProvider', 'CPUExecutionProvider'])

# Prepare input data
input_name = session.get_inputs()[0].name
input_data = np.random.randn(1, 1, 224, 224).astype(np.float32)

# Run the model
result = session.run(None, {input_name: input_data})

# Output the result
print(result)

```

```python
import onnx
import onnxruntime as ort
import numpy as np
from PIL import Image
import sys

def preprocess_image(image_path):
    # Load image
    image = Image.open(image_path).convert('L')  # Convert to grayscale
    image = image.resize((224, 224))  # Resize to the required input size
    image_data = np.array(image).astype(np.float32)
    image_data = np.expand_dims(image_data, axis=0)  # Add channel dimension
    image_data = np.expand_dims(image_data, axis=0)  # Add batch dimension
    return image_data

def main(image_path):
    # Load the ONNX model
    model_path = "quicksrnetlarge_quantized.onnx"
    session = ort.InferenceSession(model_path, providers=['QNNExecutionProvider', 'CPUExecutionProvider'])

    # Prepare input data
    input_name = session.get_inputs()[0].name
    input_data = preprocess_image(image_path)

    # Run the model
    result = session.run(None, {input_name: input_data})

    # Output the result
    print(result)

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python script.py <path_to_image>")
    else:
        main(sys.argv[1])
```