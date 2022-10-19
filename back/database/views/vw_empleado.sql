SELECT
    u.name             AS 'name',
    u.email            AS email,
    u.id               AS id,
    pe.adquirir_antiguo AS adquirir_antiguo,
    IF(pe.adquirir_antiguo IS NOT NULL,IF(pe.adquirir_antiguo = 1,'SI','NO'),NULL) AS adquiere_antiguo,
    pe.fecha_crea      AS fecha_crea,
    pe.envio_domicilio AS envio_domicilio,
    es.descripcion     AS estado_pedido,
    ci.fecha           AS fecha_cita,
    ci.hora            AS hora,
    en.estado          AS estado_envio,
    (SELECT MAX(hi.fecha) FROM historico_envios hi WHERE hi.id_envio = en.id) AS fecha_envio,
    pe.id_sede_entrega AS id_sede_entrega,
    se.descripcion     AS nombre_sede,
    u.telefono         AS telefono,
    pe.id              AS id_pedido,
    es.codigo          AS estado_codigo,
    re.valor           AS 'tipo_entrega'
FROM usuarios u
         LEFT JOIN (SELECT pe1.id_usuario, MAX(id) AS 'id' FROM pedidos pe1 GROUP BY pe1.id_usuario) AS aux ON aux.id_usuario = u.id
         LEFT JOIN pedidos pe ON pe.id = aux.id
         LEFT JOIN sedes se ON se.id = pe.id_sede_entrega
         LEFT JOIN estados es ON es.id = pe.id_estado
         LEFT JOIN citas ci ON ci.id_pedido = pe.id
         LEFT JOIN envios en ON en.id = pe.id_envio
         LEFT JOIN referencia re ON re.tabla = 'TIPO_ENTREGA' AND re.codigo = pe.envio_domicilio
WHERE (es.codigo NOT IN('BOR') OR ISNULL(es.codigo))
  AND u.email LIKE '%@pwc.com';
