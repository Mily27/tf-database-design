use universal_friends

db.createCollection('usuarios', {
    validator: {
        $jsonSchema: {
            bsonType: 'object',
            required: [
            'nombre',
            'apellido_paterno',
            'apellido_materno',
            'correo_electronico',
            'contrasenia',
            'carrera',
            'fecha_registro',
            'intereses'
            ],
            properties: {
                nombre: {
                    bsonType: 'string'
                },
                apellido_paterno: {
                    bsonType: 'string'
                },
                apellido_materno: {
                    bsonType: 'string'
                },
                correo_electronico: {
                    bsonType: 'string'
                },
                contrasenia: {
                    bsonType: 'string'
                },
                carrera: {
                    bsonType: 'string'
                },
                fecha_registro: {
                    bsonType: 'date'
                },
                intereses: {
                    bsonType: 'array',
                    minItems: 1,
                    maxItems: 5,
                    items: {
                        bsonType: 'string'
                    }
                }
            }
        }
    }
})


db.createCollection('docentes', {
    validator: {
        $jsonSchema: {
            bsonType: 'object',
            required: ['nombre', 'apellido_paterno', 'apellido_materno'],
            properties: {
                nombre: {
                    bsonType: 'string'
                },
                apellido_paterno: {
                    bsonType: 'string'
                },
                apellido_materno: {
                    bsonType: 'string'
                }
            }
        }
    }
})

db.createCollection('valoraciones', {
    validator: {
        $jsonSchema: {
            bsonType: 'object',
            required: [
                'codigo_usuario',
                'codigo_docente_valorado',
                'curso',
                'comentario',
                'puntuacion'
            ],
            properties: {
                codigo_usuario: {
                    bsonType: 'int'
                },
                codigo_docente_valorado: {
                    bsonType: 'int'
                },
                curso: {
                    bsonType: 'string'
                },
                comentario: {
                    bsonType: 'string'
                },
                puntuacion: {
                    bsonType: 'int',
                    minimum: 0,
                    maximum: 5
                }
            }
        }
    }
})
