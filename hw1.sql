CREATE TABLE libro (
	id_libro INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
    titolo VARCHAR(255),
    autori VARCHAR(255),
    lingua VARCHAR(255),
    descrizione VARCHAR(255),
    cover VARCHAR(255)
);

CREATE TABLE libreria (
	lib_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
	usr_id INTEGER NOT NULL,
    nome VARCHAR(255) NOT NULL,
    
    FOREIGN KEY (usr_id) REFERENCES utenti(id_utenti)
);

CREATE TABLE libri_libreria (
	id_libro VARCHAR(255) NOT NULL,
    id_libreria INTEGER NOT NULL,
    
    PRIMARY KEY(id_libro,id_libreria),
    FOREIGN KEY (id_libro) REFERENCES libro(id_libro),
    FOREIGN KEY (id_libreria) REFERENCES libreria(lib_id)
);

CREATE TABLE rating_libri (
	id_libro VARCHAR(255) NOT NULL,
    id_user INTEGER NOT NULL,
    rate INTEGER NOT NULL,
    
    PRIMARY KEY(id_libro,id_user),
    FOREIGN KEY (id_libro) REFERENCES libro(id_libro),
    FOREIGN KEY (id_user) REFERENCES utenti(id_utenti),
    
    CHECK (rate >= 1 AND rate <= 5)
);

DROP TABLE rating_libri;

SELECT libro.id_libro,libro.titolo,libro.autori,libro.cover,rating_libri.rate FROM libro
LEFT JOIN rating_libri
ON rating_libri.id_libro = libro.id_libro 
WHERE 
libro.id_libro IN (SELECT id_libro FROM libri_libreria 
				   WHERE 
				   id_libreria IN (SELECT lib_id FROM libreria WHERE usr_id = 5)
				  );

#Query per l'ottenimento delle librerie di un determinato utente
SELECT nome,lib_id FROM libreria WHERE usr_id = 5;

#Query per l'ottenimento dei 3 libri più votati dagli utenti
SELECT libro.id_libro,titolo,libro.autori,libro.cover,TRUNCATE(AVG(rating_libri.rate),2) AS rating_medio,COUNT(*) AS num_voti FROM rating_libri
JOIN libro ON libro.id_libro = rating_libri.id_libro
GROUP BY libro.id_libro
ORDER BY num_voti DESC
LIMIT 3;

#Query per l'ottenimento dei libri di un determinato utente con una specifica libreria, con rating associato
SELECT L1.id_libro,L1.titolo,L1.autori,L1.cover,L4.rate,L5.id_libreria,L6.nome,L6.usr_id
FROM libro AS L1
JOIN libri_libreria L5 
ON L1.id_libro = L5.id_libro
JOIN libreria L6
ON L6.lib_id = L5.id_libreria
LEFT JOIN rating_libri L4
ON L5.id_libro = L4.id_libro AND L4.id_user = L6.usr_id
WHERE L1.id_libro IN (SELECT L2.id_libro FROM libri_libreria AS L2
					  WHERE L2.id_libreria IN 
					  (SELECT L3.lib_id FROM libreria AS L3 
					  WHERE L3.usr_id = 43 AND L3.lib_id = 63)
					  )
AND L6.usr_id = 43;

#Query per l'ottenimento di tutti i libri di un determinato utente, con libreria e rating associati
SELECT L1.id_libro,L1.titolo,L1.autori,L1.cover,L4.rate,L5.id_libreria,L6.nome,L6.usr_id
FROM libro AS L1
JOIN libri_libreria L5 
ON L1.id_libro = L5.id_libro
JOIN libreria L6
ON L6.lib_id = L5.id_libreria
LEFT JOIN rating_libri L4
ON L5.id_libro = L4.id_libro AND L4.id_user = L6.usr_id
WHERE L1.id_libro IN (SELECT L2.id_libro FROM libri_libreria AS L2
					  WHERE L2.id_libreria IN 
					  (SELECT L3.lib_id FROM libreria AS L3 
					  WHERE L3.usr_id = 43)
					  )
AND L6.usr_id = 43;
                                          
#Query per la verifica di un libro già presente in libreria
SELECT * 
FROM libri_libreria
JOIN libreria ON libri_libreria.id_libreria = libreria.lib_id
WHERE libreria.usr_id = 5 AND libri_libreria.id_libro = 'BexnNAEACAAJ';

#Query per il controllo di un libro già presente in una delle librerie dell'utente
SELECT * 
FROM libri_libreria L1
JOIN libreria L2
ON L1.id_libreria = L2.lib_id
WHERE L1.id_libro = 'BexnNAEACAAJ'
AND L2.usr_id = 5;

#Query per la rimozione di una libreria --> i libri ad essa associati verranno rimossi da libri_libreria (perché è attivo ON DELETE CASCADE sulla foreign key)
DELETE FROM libreria WHERE libreria.lib_id = 1 AND libreria.usr_id = 5;