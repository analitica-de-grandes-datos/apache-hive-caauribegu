/*

Pregunta
===========================================================================

Escriba una consulta que compute la cantidad de registros por letra de la 
columna 2 y clave de la columna 3; esto es, por ejemplo, la cantidad de 
registros en tienen la letra `a` en la columna 2 y la clave `aaa` en la 
columna 3 es:

    a    aaa    5

Apache Hive se ejecutará en modo local (sin HDFS).

Escriba el resultado a la carpeta `output` de directorio de trabajo.

*/

DROP TABLE IF EXISTS t0;
CREATE TABLE t0 (
    c1 STRING,
    c2 ARRAY<CHAR(1)>, 
    c3 MAP<STRING, INT>
    )
    ROW FORMAT DELIMITED 
        FIELDS TERMINATED BY '\t'
        COLLECTION ITEMS TERMINATED BY ','
        MAP KEYS TERMINATED BY '#'
        LINES TERMINATED BY '\n';
LOAD DATA LOCAL INPATH 'data.tsv' INTO TABLE t0;

/*
    >>> Escriba su respuesta a partir de este punto <<<
*/
DROP TABLE IF EXISTS datos_final;
CREATE TABLE datos_final
AS
    SELECT c2_clave, c3_clave, count(*) 
    FROM (
        SELECT c2_clave, c3_clave
        FROM t0
        LATERAL VIEW explode(c2) t0 AS c2_clave
        LATERAL VIEW explode(c3) t0 AS c3_clave, c3_valor
        ) t0
    GROUP BY c2_clave, c3_clave
    ORDER BY c2_clave, c3_clave;

!hdfs dfs -rm -r -f /output;

INSERT OVERWRITE DIRECTORY '/output'
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
SELECT
    *
FROM
    datos_final;

!hdfs dfs -copyToLocal /output  output;

