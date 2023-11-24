/*Insertar un usuario nuevo */
  db.usuarios.insertOne({
    nombre: 'Mathias',
    apellido_paterno: 'Kunimoto',
    apellido_materno: 'Watanabe',
    correo_electronico: 'math.kuni123@gmail.com',
    contrasenia: '123456789',
    carrera: 'Ingenieria de Futbol',
    fecha_registro: new Date(),
    intereses: ['Futbol', 'CR7']
});

/*Actualizar la contraseña de un usuario */
db.usuarios.updateOne(
    { nombre: 'Mathias' },
    { $set: { contrasenia: 'TitoKuni' } }
);

/*Mostrar Apellido Paterno del Docente */
db.docentes.aggregate([
    {
      $project: {
        _id: 0,
        apellido_paterno: 1
      }
    }
]);


/*Mostrar a todos los docentes */
db.docentes.aggregate([
    {
      $project: {
        _id: 1,
        nombre: 1,
        apellido_paterno: 1,
        apellido_materno: 1
      }
    }
  ]);

