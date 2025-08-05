function fn() {
    var env = karate.env; // leer variable de entorno si existe
    var connectTimeout = karate.properties['connectTimeout'] || 30000;

    var config = {
        urlBase: 'https://fakestoreapi.com'
    };

    karate.configure('connectTimeout', connectTimeout);
    karate.configure('readTimeout', connectTimeout);
    karate.configure('ssl', true);

    return config;
}
