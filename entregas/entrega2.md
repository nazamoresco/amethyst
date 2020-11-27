# Features
* Export
  * Para exportar se desarrollo el comando export de Notes y Books.
  * En la exportacion se supone que el contenido de la nota esta en formato Markdown.
  * Se sobreescribe el archivo si existe
  * Generará muchos archivos (uno por nota exportada), respetando la estructura deTaller de directorios que plantean los cuadernos de notas.

# Refactoring
* Me parecio que el codigo de mis Commands se estaba volviendo medio engorroso por eso empeze a usar excepciones.
  * Ejemplo:
    ```ruby
    def call(args)
      instancia = Modelo.new args
      puts instancia.action
    rescue RN::Exceptions::ModelException => e
      puts e.message
    end
    ```
