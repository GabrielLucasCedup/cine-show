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
    Left = 104
    Top = 64
  end
  object driver: TFDPhysMySQLDriverLink
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
  object QFavorito: TFDQuery
    Connection = conexao
    SQL.Strings = (
      'select id from favoritos')
    Left = 320
    Top = 384
  end
end
