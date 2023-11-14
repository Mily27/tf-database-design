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
            'codigo_carrera',
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
                codigo_carrera: {
                    bsonType: 'objectId'
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


db.createCollection('secciones', {
    validator: {
        $jsonSchema: {
            bsonType: 'object',
            required : ['nombre', 'codigo_curso', 'docentes'],
            properties: {
                nombre: {
                    bsonType: 'string'
                },
                codigo_curso: {
                    bsonType: 'objectId'
                },
                docentes: {
                    bsonType: 'array',
                    minItems: 2,
                    maxItems: 7,
                    items: {
                        bsonType: 'object',
                        required: ['codigo_docente', 'cargo'],
                        properties: {
                            codigo_docente: {
                                bsonType: 'objectId'
                            },
                            cargo: {
                                bsonType: 'string'
                            }
                        }
                    }
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
                    bsonType: 'objectId'
                },
                codigo_docente_valorado: {
                    bsonType: 'objectId'
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
