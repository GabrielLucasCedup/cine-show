object dm: Tdm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 562
  Width = 727
  object conexao: TFDConnection
    Params.Strings = (
      'Port=3307'
      'Database=sistema_cineshow'
      'User_Name=root'
      'Password=3307'
      'Server=localhost'
      'DriverID=MySQL')
    Connected = True
    Left = 104
    Top = 64
  end
  object driver: TFDPhysMySQLDriverLink
    VendorLib = 
      'E:\Git Lucas\gabriellucas353\Desenvolvimento Sistemas\SistemaGen' +
      'erico\cine-show\libs\libmySQL.dll'
    Left = 176
    Top = 136
  end
  object QUser: TFDQuery
    Connection = conexao
    SQL.Strings = (
      'select * from usuario')
    Left = 320
    Top = 152
  end
end
