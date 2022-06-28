from api.applications.base import ApiError
from api.models import MedicalRecord


class MedicalRecordApp:

    @staticmethod
    def create(**data_dict):
        MedicalRecord.objects.create(
            pasien_id = data_dict.get("nim"),
            diagnosa = data_dict.get("diagnosa"),
            treatment = data_dict.get("treatment")
        )
    
    @staticmethod
    def get(nim: str):
        data = MedicalRecord.objects.filter(pasien_id=nim)
        if data.first() is None:
            raise ApiError("Empty Record!")
        return list(data.values())  

    @staticmethod
    def delete(id: int):
        data = MedicalRecord.objects.filter(id=id)
        if data.first() is None:
            raise ApiError("Data doesn't exist!")
        data.delete()   

    
