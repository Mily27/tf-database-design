// Puntuacion promedio por curso
db.valoraciones.aggregate([
    {
       $group: {
          _id: "$curso",
          puntuacion_promedio: { $avg: "$puntuacion" }
       }
    }
]);
