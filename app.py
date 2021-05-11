import io
from PIL import Image
from flask import Flask, request
from evaluator import Model

app = Flask(__name__)
model = Model()

@app.route('/', methods=['POST'])
def predict():
    try:
        images_data = []
        if len(request.files) > 0:
            for key in request.files:
                images_data.append(request.files[key])
        elif len(request.form) > 0:
            for key in request.form:
                images_data.append(request.files[key])
        else:
            images_data[0] = io.BytesIO(request.get_data())
        
        images = []
        for image_data in images_data:
            images.append(Image.open(image_data))
        
        if len(images) == 0:
            raise Exception('No images')
        
        results = model.predict(images)

        return results, 200
    except Exception as e:
        print('Exception: ', str(e))
        return 'Error processing image', 500

if __name__ == '__main__':
    app.run(debug=True)