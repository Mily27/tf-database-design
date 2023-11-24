/*Insertar un docente nuevo */
db.docentes.insertOne({
    nombre: 'Alan',
    apellido_paterno: 'Tito',
    apellido_materno: 'Gutierrez'
});

/*Buscar Alumnos por carreras y dar con la info */
db.usuarios.find({
    $or: [
        { carrera: 'Ingeniería Informática' },
        { carrera: 'Medicina' },
        { carrera: 'Administración de Empresas' }
    ]
});
