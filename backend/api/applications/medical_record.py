from api.applications.base import ApiError
from api.models import Akun, MedicalRecord


class MedicalRecordApp:

    @staticmethod
    def create(**data_dict):
        nim = data_dict.get("nim")
        try:
            obj = Akun.objects.get(nim=nim)
        except Akun.DoesNotExist:
            raise ApiError("NIM is not registered!")
        MedicalRecord.objects.create(
            pasien_id = data_dict.get("nim"),
            dokter = data_dict.get("dokter"),
            diagnosa = data_dict.get("diagnosa"),
            treatment = data_dict.get("treatment")
        )
    
    @staticmethod
    def get(nim: str):
        konselor_check = Akun.objects.filter(nim=nim).values("is_konselor").first()
        data = None
        if konselor_check is None:
            raise ApiError("Not Logged In!")
        if konselor_check["is_konselor"]:
            data = MedicalRecord.objects.filter(dokter=nim)
        else:
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

    
