# Decisiones que tome durante el desarrollo:

### Modificación del template por mi "comodidad"
* Dividi los comandos en multiples pequeños archivos, creo que navegar entre archivos en un proyecto bien estructurado es mucho mas comodo que navegar en un gran archivo.

* Movi las definiciones de modulos a una linea, estaban ocupando demasiado porcentaje del archivo, si quiero leer los modulos que contienen a la clase prefiero leer solo una linea.

### Desiciones de implementacion
* Cuando se crea una nota en vez de nombrar al metodo `:create` lo nombre `:persist`, esto rompe un poco la consistencia de nombre pero me parece un nombre mas adecuado para lo que se hace en el metodo.
  * No cambie el nombre del comando en si porque desde una perspectiva del usuario el esta creando una nota, persistir me parece un termino demasiado tecnico para un usuario.

* Uso :open sobre :new para instanciar las Clases en alguno casos porque :new se puede malinterpretar como que se esta creando una nueva nota

* Incluyo todo el nombre con los modulos en vez de hacer el include del modulo.
  ```ruby
    # No
    include Modulo::Largo
    metodo
    # Si
    Modulo::Largo::metodo
  ```
  * Duele un poco en el ojo pero lei que podia ser una mala práctica por el colapso de nombres y estoy de acuerdo.


>  * Hice que la llamada desde la interfaz sea a call y que el comando se llame con process
>    * No estoy tan seguro sobre esto, pero me hace ruido mandarle la lógica de interfaz a mi comando, algunos ejemplos para justificar mi miedo:
>
>  ```ruby
>    # Ejemplo - 1
>    def call
>      puts process
>    end
>
>    def process
>      "Buenas"
>    end
>
>    # Ejemplo - 2
>    def call
>      template_name, *template_args = process
>      template_path File.join RN::Command::Configuration.TEMPLATES_PATH, template_name
>      render_template template_path, *template_args
>    end
>
>    def process
>      template_2, book
>    end
>  ```
* En la clase 11/05 se hablo de no separar interfaz del command en un intento de replicar MVC, si el proyecto se va a mantener en CLI estoy de acuerdo en que no tiene mucho sentido.
    * Por esta razón, commands se encarga de la logica relacionada a los flags, de hacer llamadas al modelo con parametros sanitizados y de la interfaz, mientras que el modelo se encarga de responder consultas sobre el objeto que representan. * Si se extiende a un interfaz mas compleja podría contemplarse revertir este cambio.

* El module "Configuration" se encarga de manejar justamente configuraciones y de inicializar y destruir la estructura de directorio.

* Los tests se encuentran bajo la carpeta spec separada de lib esto porque me parece una carpeta mas relacionada con el desarrollo que con el uso potencial en producción.

### Desiciones de UX
* Prefiero que el comando falle si se ponen flags incorrectos
  * Por eso pido comandos en especifico en vez de `**options`

* En el edit podes usar un editor para no sobrescribir todo lo que tenes adentro pero este no es la opcion por default.

* No voy a permitir crear por ahora un cuaderno mediante la creacion de una nota.
  * Es decir si se intenta crear una nota con un cuaderno inexistente el comando falla.

* Para simplificar por ahora solo permito nombres que esten compuestos de letras, numeros y guiones bajos.

### Modelo
* El modelo es bastante sencillo, tenemos un modelo notas con titulo y un libro asociado, y un libro con titulo.
  * Me parece que los detalles se pueden deducir observando el codigo entre los tests, los commands y el modelo en si.
