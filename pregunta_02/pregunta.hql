/* 
Pregunta
===========================================================================

Para resolver esta pregunta use el archivo `data.tsv`.

Construya una consulta que ordene la tabla por letra y valor (3ra columna).

Apache Hive se ejecutará en modo local (sin HDFS).

Escriba el resultado a la carpeta `output` de directorio de trabajo.

        >>> Escriba su respuesta a partir de este punto <<<
*/
DROP TABLE IF EXISTS DATOS;
CREATE TABLE data (letra STRING,
fecha STRING,
valor INT)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t';  

INSERT OVERWRITE LOCAL DIRECTORY './output' 
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
SELECT * FROM data ORDER BY letra,valor;


