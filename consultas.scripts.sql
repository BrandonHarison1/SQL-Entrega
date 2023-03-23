-- Listar las pistas (tabla Track) con precio mayor o igual a 1€ --

SELECT  T.TrackId, 
		T.Name, 
		T.AlbumId, 
		T.MediaTypeId, 
		T.GenreId, 
		T.Composer, 
		T.Milliseconds, 
		T.Bytes, 
		T.UnitPrice 
FROM dbo.Track T 
WHERE UnitPrice >= 1

-- Listar las pistas de más de 4 minutos de duración --

SELECT  T.TrackId, 
		T.Name, 
		T.AlbumId, 
		T.MediaTypeId, 
		T.GenreId, 
		T.Composer, 
		T.Milliseconds, 
		T.Bytes, 
		T.UnitPrice 
FROM dbo.Track T 
WHERE (Milliseconds/1000)/60 >= 4

-- Listar las pistas que tengan entre 2 y 3 minutos de duración --

SELECT  T.TrackId, 
		T.Name, 
		T.AlbumId, 
		T.MediaTypeId, 
		T.GenreId, 
		T.Composer, 
		T.Milliseconds, 
		T.Bytes, 
		T.UnitPrice 
FROM dbo.Track T 
WHERE (Milliseconds/1000)/60 BETWEEN 2 AND 2

-- Listar las pistas que uno de sus compositores (columna Composer) sea Mercury --

SELECT  T.TrackId, 
		T.Name, 
		T.AlbumId, 
		T.MediaTypeId, 
		T.GenreId, 
		T.Composer, 
		T.Milliseconds, 
		T.Bytes, 
		T.UnitPrice 
FROM dbo.Track T 
WHERE T.Composer LIKE '%Mercury%'

-- Calcular la media de duración de las pistas (Track) de la plataforma --

SELECT AVG(T.Milliseconds) AS Duracion_media
FROM dbo.Track T 

-- Listar los clientes (tabla Customer) de USA, Canada y Brazil --

SELECT C.CustomerId,
	   C.FirstName,
	   C.LastName,
	   C.Company,
	   C.Address,
	   C.City,
	   C.State,
	   C.Country,
	   C.PostalCode,
	   C.Phone,
	   C.Fax,
	   C.Email, 
	   C.SupportRepId
FROM dbo.Customer C
WHERE C.Country IN ('USA', 'Canada', 'Brazil')

-- Listar todas las pistas del artista 'Queen' (Artist.Name = 'Queen') --

SELECT T.TrackId, 
		T.Name, 
		T.AlbumId, 
		T.MediaTypeId, 
		T.GenreId, 
		T.Composer, 
		T.Milliseconds, 
		T.Bytes, 
		T.UnitPrice 
FROM dbo.Artist A
INNER JOIN dbo.Album Al ON A.ArtistId = Al.ArtistId
INNER JOIN dbo.Track T ON Al.AlbumId = T.AlbumId
WHERE A.Name = 'Queen'

-- Listar las pistas del artista 'Queen' en las que haya participado como compositor David Bowie --

SELECT T.TrackId, 
		T.Name, 
		T.AlbumId, 
		T.MediaTypeId, 
		T.GenreId, 
		T.Composer, 
		T.Milliseconds, 
		T.Bytes, 
		T.UnitPrice 
FROM dbo.Artist A
INNER JOIN dbo.Album Al ON A.ArtistId = Al.ArtistId
INNER JOIN dbo.Track T ON Al.AlbumId = T.AlbumId
WHERE A.Name = 'Queen' AND T.Composer LIKE ('%David Bowie%')

-- Listar las pistas de la playlist 'Heavy Metal Classic' --

SELECT  T.TrackId, 
		T.Name, 
		T.AlbumId, 
		T.MediaTypeId, 
		T.GenreId, 
		T.Composer, 
		T.Milliseconds, 
		T.Bytes, 
		T.UnitPrice,
		P.Name AS Playlist
FROM dbo.PlaylistTrack PT
INNER JOIN dbo.Track T ON PT.TrackId = T.TrackId
INNER JOIN dbo.Playlist P ON P.PlaylistId = PT.PlaylistId
WHERE P.Name = 'Heavy Metal Classic'

-- Listar las playlist junto con el número de pistas que contienen --

SELECT  P.PlaylistId, P.Name, COUNT(*) AS Numero_pistas
FROM dbo.Playlist P
INNER JOIN dbo.PlaylistTrack PT ON PT.PlaylistId = P.PlaylistId
GROUP BY P.PlaylistId, P.Name

-- Listar las playlist (sin repetir ninguna) que tienen alguna canción de AC/DC --

SELECT DISTINCT P.PlaylistId, P.Name
FROM dbo.Playlist P
INNER JOIN dbo.PlaylistTrack PT ON PT.PlaylistId = P.PlaylistId
INNER JOIN dbo.Track T ON T.TrackId = PT.TrackId
WHERE T.Composer = 'AC/DC'

-- Listar las playlist que tienen alguna canción del artista Queen, junto con la cantidad que tienen --

SELECT P.PlaylistId, P.Name, COUNT(*) AS Numero_Canciones_Queen
FROM dbo.Playlist P
INNER JOIN dbo.PlaylistTrack PT ON PT.PlaylistId = P.PlaylistId
INNER JOIN dbo.Track T ON T.TrackId = PT.TrackId
WHERE T.Composer = 'Queen'
GROUP BY P.PlaylistId, P.Name

-- Listar las pistas que no están en ninguna playlist --

SELECT  T.TrackId, 
		T.Name, 
		T.AlbumId, 
		T.MediaTypeId, 
		T.GenreId, 
		T.Composer, 
		T.Milliseconds, 
		T.Bytes, 
		T.UnitPrice
FROM dbo.Track T
WHERE T.TrackId NOT IN (SELECT PT.TrackId FROM dbo.PlaylistTrack PT)

-- Listar los artistas que no tienen album --

SELECT  A.ArtistId, A.Name
FROM dbo.Artist A
WHERE A.ArtistId NOT IN (SELECT AL.ArtistId FROM dbo.Album AL)

-- Listar los artistas con el número de albums que tienen --

SELECT  A.ArtistId, 
        A.Name, 
        COUNT(AL.AlbumId) AS Numero_Albumes
FROM dbo.Artist A
LEFT JOIN dbo.Album AL ON AL.ArtistId = A.ArtistId
GROUP BY A.ArtistId, A.Name






