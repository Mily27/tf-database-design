// Calcula la cantidad de usuarios que comparten el mismo interés
db.usuarios.aggregate([
    {
        $unwind: "$intereses"
    },
    {
        $group: {
            _id: { $toLower: "$intereses" },
            cantidad_usuarios: { $count: {} }
        }
    },
    {
        $sort: { cantidad_usuarios: -1 }
    }
]);

// Calcula la diferencia en días entre la fecha actual y la fecha de registro de cada usuario
db.usuarios.aggregate([{
    $project: {
        _id: 1,
        nombre: 1,
        dias_desde_registro: {
            $divide: [{
                $subtract: [new Date(), "$fecha_registro"] },
                1000 * 60 * 60 * 24
            ]
        }
    }
}]);
