-- Listar las pistas ordenadas por el número de veces que aparecen en playlists de forma descendente --

SELECT  T.TrackId, 
		T.Name, 
		T.AlbumId, 
		T.MediaTypeId, 
		T.GenreId, 
		T.Composer, 
		T.Milliseconds, 
		T.Bytes, 
		T.UnitPrice,
		COUNT(PT.TrackId) AS Apariciones_Playlist
FROM dbo.Track T
INNER JOIN dbo.PlaylistTrack PT ON PT.TrackId = T.TrackId
GROUP BY T.TrackId, 
		 T.Name, 
		 T.AlbumId, 
		 T.MediaTypeId, 
		 T.GenreId, 
		 T.Composer, 
		 T.Milliseconds, 
		 T.Bytes, 
		 T.UnitPrice
ORDER BY Apariciones_Playlist DESC

-- Listar las pistas más compradas (la tabla InvoiceLine tiene los registros de compras) --

SELECT  T.TrackId, 
		T.Name, 
		T.AlbumId, 
		T.MediaTypeId, 
		T.GenreId, 
		T.Composer, 
		T.Milliseconds, 
		T.Bytes, 
		T.UnitPrice,
		SUM(IL.Quantity) AS Compras
FROM dbo.Track T
INNER JOIN dbo.InvoiceLine IL ON IL.TrackId = T.TrackId
INNER JOIN dbo.Invoice I ON I.InvoiceId = IL.InvoiceId
GROUP BY T.TrackId, 
		T.Name, 
		T.AlbumId, 
		T.MediaTypeId, 
		T.GenreId, 
		T.Composer, 
		T.Milliseconds, 
		T.Bytes, 
		T.UnitPrice
ORDER BY Compras DESC

-- Listar los artistas más comprados --

SELECT  A.ArtistId,
		A.Name,
		COUNT(IL.Quantity) AS Num_Ventas
FROM dbo.Artist A
INNER JOIN dbo.Album AL ON AL.ArtistId = A.ArtistId
INNER JOIN dbo.Track T ON T.AlbumId = AL.AlbumId
INNER JOIN dbo.InvoiceLine IL ON IL.TrackId = T.TrackId
GROUP BY A.ArtistId,
		A.Name
ORDER BY Num_Ventas DESC

-- Listar las pistas que aún no han sido compradas por nadie --

SELECT  T.TrackId, 
		T.Name, 
		T.AlbumId, 
		T.MediaTypeId, 
		T.GenreId, 
		T.Composer, 
		T.Milliseconds, 
		T.Bytes, 
		T.UnitPrice,
		SUM(IL.Quantity) AS Compras
FROM dbo.Track T
LEFT JOIN dbo.InvoiceLine IL ON IL.TrackId = T.TrackId
LEFT JOIN dbo.Invoice I ON I.InvoiceId = IL.InvoiceId
GROUP BY T.TrackId, 
		T.Name, 
		T.AlbumId, 
		T.MediaTypeId, 
		T.GenreId, 
		T.Composer, 
		T.Milliseconds, 
		T.Bytes, 
		T.UnitPrice
HAVING SUM(IL.Quantity) = 0

-- Listar los artistas que aún no han vendido ninguna pista --

SELECT  A.ArtistId,
		A.Name,
		COUNT(IL.Quantity) AS Num_Ventas
FROM dbo.Artist A
LEFT JOIN dbo.Album AL ON AL.ArtistId = A.ArtistId
LEFT JOIN dbo.Track T ON T.AlbumId = AL.AlbumId
LEFT JOIN dbo.InvoiceLine IL ON IL.TrackId = T.TrackId
GROUP BY A.ArtistId,
		A.Name
HAVING COUNT(IL.Quantity) = 0
ORDER BY Num_Ventas DESC

