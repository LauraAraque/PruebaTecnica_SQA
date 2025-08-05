Feature: validacion funcionamiento api

  Background:

    * url urlBase
    * def registro = read('classpath:jsonrequest/registro.json')
    * def autenticacion = read('classpath:jsonrequest/autenticacion.json')
    * def actualizacion = read('classpath:jsonrequest/actualizacion.json')
    * def detalleProdcutoResponse = read('classpath:jsonresponse/detalleProductoResponse.json')


  Scenario: el usuaio va a listar los productos
    Given path '/products'
    When method GET
    * print "respuesta del servicio", response
    Then status 200

  Scenario Outline: consultar detalle del producto
    Given path '/products/<id>'
    When method GET
    * print "respuesta del servicio", response
    Then status 200
    And match response == detalleProdcutoResponse

    Examples:

      | id |
      | 2  |
      | 3  |

  Scenario Outline: registro de nuevos usuarios
    Given path '/users'
    * set registro.id = <id>
    * set registro.username = <nombre>
    * set registro.email = <correo>
    * set registro.password = <contrasena>
    * request registro
    When method POST
    * print "respuesta del servicio", response
    Then status 201

    Examples:
      | id | nombre  | correo                     | contrasena  |
      | 21 | "laura" | "laura.araque@hotmail.com" | "holamundo" |

  Scenario Outline: autenticacion de usuario
    Given path '/auth/login'
    * set autenticacion.username = <nombre>
    * set autenticacion.password = <contrasena>
    * request autenticacion
    When method POST
    * print "respuesta del servicio", response
    Then status <status>

    Examples:
      | nombre     | contrasena  | status |
      | "mor_2314" | "83r5^_"    | 201    |
      | "laura"    | "holamundo" | 401    |

  Scenario: obtener carrito del usuario 2
    Given path '/carts/user/2'
    When method GET
    * print "respuesta del servicio", response
    Then status 200

  Scenario: eliminar carrito con id 4
    Given path '/carts/4'
    When method DELETE
    * print "respuesta del servicio", response
    Then status 200

  Scenario Outline: actualizar 2 productos
    Given path '/products/<id>'
    * set actualizacion.id = <id>
    * set actualizacion.title = <titulo>
    * set actualizacion.price = <precio>
    * set actualizacion.description = <descripcion>
    * set actualizacion.category = <categoria>
    * set actualizacion.image = <imagen>
    * request actualizacion
    When method PUT
    * print "Producto actualizado:", response
    Then status 200

    Examples:
      | id | titulo     | precio | descripcion       | categoria    | imagen                          |
      | 1  | "cargador" | 70.00  | "cargador tipo c" | "tecnologia" | "http://example.com/image1.jpg" |
      | 2  | "teclado"  | 30.50  | "teclado gamer"   | "tecnologia" | "http://example.com/image2.jpg" |