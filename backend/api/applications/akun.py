from api.applications.base import ApiError
from api.models import Akun


class AkunApp:

    @staticmethod
    def register_akun(**akun_dict):
        try:
            akun = Akun.objects.get(nim=akun_dict.get("nim"))
            raise ApiError("Akun telah terdaftar!")
        except Akun.DoesNotExist:
            Akun.objects.create(**akun_dict)
    
    @staticmethod
    def update_akun(nim: str, **akun_dict):
        try:
            nim = Akun.objects.get(nim=nim)
            nim.update(**akun_dict)
        except Akun.DoesNotExist:
            AkunApp.register_akun(**akun_dict)
    
    @staticmethod
    def delete_akun(nim: str):
        nim = Akun.objects.filter(nim=nim)
        nim.delete()
    
    @staticmethod
    def get_akun(nim: str):
        return Akun.objects.filter(nim=nim).values().first()
    
    @staticmethod
    def login(username: str, password: str):
        check_uname = Akun.objects.filter(username=username)
        if check_uname.first() is None:
            raise ApiError("Username tidak terdaftar")
        if check_uname.first().password != password:
            raise ApiError("Password Salah")
        return check_uname.values().first()
        


