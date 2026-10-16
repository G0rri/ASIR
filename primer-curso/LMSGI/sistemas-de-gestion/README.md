# 🏪 Sistemas de gestión de información: ERP, CRM y CMS

Proyecto del 3º trimestre en tres entregas encadenadas sobre un mismo caso: analizar cómo se gestiona un **pequeño negocio real** y proponerle herramientas digitales, primero con el ERP/CRM **Odoo** y después con el gestor de contenidos **WordPress**.

> 🔒 El negocio analizado era real; aquí se describe de forma anónima, sin nombre, ubicación ni datos de las personas entrevistadas.

## 1. Análisis del negocio

**La empresa**: una peluquería familiar de barrio con tres trabajadores, que además de los servicios de corte, color y estética vende productos para el cabello. La información se obtuvo mediante una entrevista a sus responsables.

**Cómo trabajan**:

| Área | Situación |
|---|---|
| Citas | Por teléfono, anotadas a mano en una agenda de papel; también se puede acudir sin cita, sin garantía de ser atendido |
| Ventas | Cobro con un **TPV** (tarjeta y NFC) |
| Gestión | Un PC con Windows 10 y un programa de gestión para TPV: inventario de productos, fichas de clientes y ventas |
| Pedidos | Reserva por teléfono y recogida en el local, o encargo de productos agotados; sin envíos a domicilio |
| Nóminas | Externalizadas a una gestoría |
| Presencia digital | Un perfil en una red social y la ficha de Google Maps; sin página web |

**Propuestas de mejora**:

1. **Reserva de citas en línea**, que sustituya a la agenda de papel y evite solapamientos.
2. **Página web** con información, catálogo y tienda.
3. **Más canales en redes sociales** para ampliar el alcance, aunque sea un negocio de barrio.

## 2. Odoo: ERP y CRM

**Odoo** es un ERP modular: un único sistema para ventas, inventario, contabilidad, recursos humanos, web… que se amplía activando módulos. Uno de ellos es un **CRM** (*Customer Relationship Management*), que centraliza la relación con los clientes: contactos, oportunidades, presupuestos y seguimiento comercial. Un CRM puede instalarse en servidores propios (local) o usarse como servicio en la nube.

Implantación sobre el caso de la peluquería, en la versión en la nube:

| Módulo | Qué se configuró |
|---|---|
| **Sitio web** | Web creada con el asistente a partir de una plantilla según el tipo de negocio; editor visual por bloques, muy parecido a WordPress |
| **CRM** | Organizaciones y contactos, generación de clientes potenciales, embudo de ventas y presupuestos |
| **Informes** | Gráficas de ventas (barras, circulares…) exportables a hoja de cálculo |
| **Comercio electrónico** | Tienda con herramientas y productos capilares, con carrito, dirección de envío y costes |
| **Citas** | Reserva en línea con días, horarios y duración de cada servicio: la mejora más importante para el negocio |
| **Ventas** | Presupuestos y pedidos con los datos del cliente y los productos |
| **Hojas de horas** | Registro del tiempo dedicado a cada tarea, al estilo de Toggl |

**Conclusiones**: Odoo cubre en una sola herramienta las mejoras propuestas en el análisis (citas y venta en línea) y es muy intuitivo para crear la web, aunque muchas funciones útiles son de pago y el coste crece con cada módulo.

## 3. WordPress: CMS

**WordPress** es un gestor de contenidos libre escrito en PHP que guarda sus datos en MySQL. Nació como plataforma de blogs y hoy mueve una gran parte de las webs de Internet.

| | WordPress.org | WordPress.com |
|---|---|---|
| Alojamiento | En tu propio servidor | En los servidores de Automattic |
| Temas y *plugins* | Cualquiera | Limitados en los planes gratuitos |
| Control | Total | Parcial |

### Instalación local con XAMPP

1. Instalar **XAMPP** y arrancar **Apache** y **MySQL** desde su panel de control.
2. Descomprimir WordPress en `C:\xampp\htdocs\wordpress`.
3. En **phpMyAdmin** (`http://localhost/phpmyadmin`) crear una base de datos vacía:

   ```sql
   CREATE DATABASE wordpress CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
   ```

4. Abrir `http://localhost/wordpress` y completar el asistente: nombre de la base de datos, usuario (`root`), contraseña (en XAMPP viene **vacía** por defecto) y servidor (`localhost`).
5. Título del sitio y usuario administrador; el panel queda en `http://localhost/wordpress/wp-admin`.

> En un servidor real, WordPress debe conectarse con un usuario de MySQL propio con permisos solo sobre su base de datos, nunca con `root`.

### El panel de administración

| Sección | Para qué |
|---|---|
| Escritorio | Resumen, estado de salud del sitio y actualizaciones |
| Entradas | Artículos con categorías y etiquetas |
| Medios | Biblioteca de imágenes y archivos |
| Páginas | Contenido estático: inicio, contacto… |
| Comentarios | Moderación, *spam* y respuestas |
| Apariencia | Temas, editor del sitio y *plugins* recomendados por el tema |
| Plugins | Instalar, activar y actualizar extensiones |
| Usuarios | Cuentas y roles (administrador, editor, autor, suscriptor…) |
| Herramientas | Importar y exportar contenido, salud del sitio, exportar y borrar datos personales (RGPD) |
| Ajustes | Título, formato de fecha, lectura, comentarios, medios, enlaces permanentes y privacidad |

### Lo que se construyó

- **Página de aterrizaje** para el negocio con un tema oficial: los temas publicados por WordPress.org dieron mejor resultado que los de terceros, que suelen exigir muchos *plugins*.
- **Formulario de contacto** con **Ninja Forms**; los envíos quedan registrados en el propio panel.
- ***Plugins*** de serie: Akismet (anti-*spam*) y Hello Dolly.
- **Google Analytics** con el *plugin* MonsterInsights: la cuenta se creó, pero la vinculación falla en una instalación local, porque el sitio tiene que estar publicado en Internet.

**Conclusiones**: WordPress permite montar una web profesional sin programar y también ahorra tiempo a quien sí sabe, pero cada *plugin* es código de terceros con acceso al sitio: conviene instalar solo los necesarios, de fuentes fiables y mantenerlos actualizados.
