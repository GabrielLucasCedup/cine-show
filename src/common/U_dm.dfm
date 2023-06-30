object dm: Tdm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 562
  Width = 727
  object conexao: TFDConnection
    Params.Strings = (
      'Database=sistema_cineshow'
      'User_Name=root'
      'Server=localhost'
      'Port=3307'
      'Password=3307'
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
    Top = 144
  end
  object QMedia: TFDQuery
    Active = True
    Connection = conexao
    SQL.Strings = (
      'select nome_midia from midia')
    Left = 320
    Top = 232
  end
  object QRetomar: TFDQuery
    Connection = conexao
    SQL.Strings = (
      'select midia_id from retomar')
    Left = 320
    Top = 312
  end
end
