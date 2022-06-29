/* 
Pregunta
===========================================================================

Para resolver esta pregunta use el archivo `data.tsv`.

Escriba una consulta que devuelva los cinco valores diferentes más pequeños 
de la tercera columna.

Apache Hive se ejecutará en modo local (sin HDFS).

Escriba el resultado a la carpeta `output` de directorio de trabajo.

        >>> Escriba su respuesta a partir de este punto <<<
*/
CREATE TABLE data (letra STRING, fecha DATE, valor INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' TBLPROPERTIES ("skip.header.line.count"="0");
LOAD DATA LOCAL INPATH "data.tsv" OVERWRITE INTO TABLE data;
CREATE TABLE word_counts9 AS SELECT valor, count(1) FROM data GROUP BY valor order by valor;
INSERT OVERWRITE LOCAL DIRECTORY './output' ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' SELECT valor FROM word_counts9 order by valor limit 5;

