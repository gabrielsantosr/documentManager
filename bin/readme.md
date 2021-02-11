
Hay que crear una base de datos llamada 'literature_manager'.
En hibernate.cfg.xml hay que agregar los datos de conexión.
No hay que crear las tablas. Se crean solas al correr App.java

Hay un META-INF con un archivo de configuración por si paso
la EntityManagerFactory a JPA. No está en uso.

La aplicación TestDAO es para ver si funciona la implementación
que hice de la interfaz DAO a través de la clase DAOImpl.
