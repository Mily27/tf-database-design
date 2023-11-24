/* Buscar Carreras Seleccionadas */
 db.usuarios.aggregate([
    {
      $match: {
        $or: [
          { carrera: 'Ingeniería Informática' },
          { carrera: 'Medicina' },
          { carrera: 'Administración de Empresas' }
        ]
      }
    }
  ]);

  /*Contar Cantidad de usuarios por carrera */
  db.usuarios.aggregate([
    {
      $group: {
        _id: "$carrera",
        cantidad: { $sum: 1 }
      }
    }
  ]);
