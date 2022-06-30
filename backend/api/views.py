import json

from django.views import View
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.utils.decorators import method_decorator
from api.applications.akun import AkunApp
from api.applications.base import ApiError
from api.applications.medical_record import MedicalRecordApp

from api.models import *
from api.recommender import Recommender


class FoodRecommendationsView(View):

    @method_decorator([csrf_exempt])
    def post(self, request):
        data = json.loads(request.body.decode("utf-8"))
        input_data = {
            "energy": float(data["energy"]),
            "carbo": float(data["carbo"]),
            "protein": float(data["protein"]),
            "fat" : float(data["fat"]),
            "fiber": float(data["fiber"]),
            "cholestrol": float(data["cholestrol"])
        }
        food = Recommender(input_data)
        result = food.recommender()
        return JsonResponse({"message": "ok", "data": result})


class AkunView(View):

    def get(self, request, nim: str):
        return JsonResponse({"message": "ok", "data": AkunApp.get_akun(nim)})
    
    @method_decorator([csrf_exempt])
    def post(self, request):
        data = json.loads(request.body.decode("utf-8"))
        try:
            AkunApp.register_akun(**data)
            return JsonResponse({"message":"Registration successfully"})
        except ApiError as e:
            return JsonResponse({"message": str(e)}, status=404)
    
    @method_decorator([csrf_exempt])
    def put(self, request):
        data = json.loads(request.body.decode("utf-8"))
        AkunApp.update_akun(data["nim"], **data)
        return JsonResponse({"message":"Update data successfully!"})
    
    @method_decorator([csrf_exempt])
    def delete(self, request, nim: str):
        AkunApp.delete_akun(nim)
        return JsonResponse({"message":"Delete data successfully!"})
    

class LoginView(View):

    @method_decorator([csrf_exempt])
    def post(self, request):
        data = json.loads(request.body.decode("utf-8"))
        try:
            data = AkunApp.login(username=data["username"], password=data["password"])
            return JsonResponse({"message":"ok", "data": data})
        except ApiError as e:
            return JsonResponse({"message": str(e)}, status=404)


class MedicalRecordView(View):

    def get(self, request, nim: str):
        try:
            return JsonResponse({"message": "ok", "data": MedicalRecordApp.get(nim)})
        except ApiError as e:
            return JsonResponse({"message": str(e)}, status=404)
    
    @method_decorator([csrf_exempt])
    def post(self, request):
        try:
            data = json.loads(request.body.decode("utf-8"))
            MedicalRecordApp.create(**data)
            return JsonResponse({"message": "ok"})
        except ApiError as e:
            return JsonResponse({"message": str(e)}, status=404)
    
    @method_decorator([csrf_exempt])
    def delete(self, request, id: int):
        MedicalRecordApp.delete(id)
        return JsonResponse({"message":"Delete data successfully!"})


