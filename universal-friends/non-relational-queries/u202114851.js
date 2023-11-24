// Puntuacion promedio por curso
db.valoraciones.aggregate([
    {
       $group: {
          _id: "$curso",
          puntuacion_promedio: { $avg: "$puntuacion" }
       }
    }
]);

// Obtener la cantida de usuarios por carrera
db.usuarios.aggregate([
    {
       $group: {
          _id: "$carrera",
          cantidad_usuarios: { $sum: 1 }
       }
    }
]);