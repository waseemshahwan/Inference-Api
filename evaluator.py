import torch
import json

class Model():
    model = torch.hub.load('ultralytics/yolov5', 'custom', path='model/best.pt')

    def predict(self, images):
        results = self.model(images, size=640)
        return json.dumps([json.loads(i.to_json(orient="records")) for i in results.pandas().xyxy])

# if __name__ == '__main__':
#     import os
#     import cv2

#     runner = Model()
    
#     for file in os.listdir('./model/test_images'):
#         print(runner.predict(cv2.imread('./model/test_images/' + file)))