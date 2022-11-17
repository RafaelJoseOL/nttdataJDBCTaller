package com.nttdata.jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Formacion - JDBC - Escritores
 * 
 * Clase principal
 * 
 * @author Rafael José Ossorio López
 *
 */
public class App {
	private static final Logger LOG = LoggerFactory.getLogger(App.class);

	/**
	 * Metodo principal
	 * 
	 * @param args
	 */
	public static void main(String[] args) {
		LOG.info("Inicio del método main");

		// Llamada al método encargado de conectar con la BBDD.
		dbConnection();
	}

	/**
	 * 
	 * Conexion con la BBDD MySQL
	 * 
	 */
	private static void dbConnection() {
		try {
			// Se establece el driver.
			Class.forName("com.mysql.cj.jdbc.Driver");

			// Conexión con la BBDD (URL / Usuario / Contraseña).
			try (final Connection dataBaseConnection = DriverManager
					.getConnection("jdbc:mysql://localhost:3306/nttdata_jdbc_writers", "root", "root")) {

				// Llamada al método que inicia la consulta a la BBDD.
				writersQuery(dataBaseConnection);
			}

			LOG.info("Fin de la ejecución del programa");
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 
	 * Metodo para realizar consulta sobre los escritores.
	 * 
	 * @param dbConnection
	 * @return
	 * @throws SQLException
	 * 
	 */
	private static void writersQuery(final Connection dbConnection) {

		try (final Statement sentenceWriters = dbConnection.createStatement()) {

			// Creación de la consulta sobre escritores.
			final String queryWriters = "SELECT w.name AS writerName, w.last_name as writerLastName, "
					+ "w.id_writer as idWriter FROM nttdata_mysql_writer w";
			final ResultSet queryResultWriters = sentenceWriters.executeQuery(queryWriters);

			// Mientras existan escritores, seguirá iterando y sacando la información sobre
			// los mismos.
			while (queryResultWriters.next()) {
				LOG.info("\tEscritor: {} {}", queryResultWriters.getString("writerName"),
						queryResultWriters.getString("writerLastName"));

				// Llamada al método que realizará las consultas sobre las sagas de cada
				// escritor.
				seriesQuery(dbConnection, queryResultWriters);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 
	 * Metodo para realizar una consulta sobre las sagas de cada escritor.
	 * 
	 * @param dbConnection
	 * @param queryResultWriters
	 * @throws SQLException
	 * 
	 */
	private static void seriesQuery(final Connection dbConnection, final ResultSet queryResultWriters) {

		try (final Statement sentenceSeries = dbConnection.createStatement()) {

			// Creación de la consulta sobre sagas.
			final String querySeries = "SELECT s.name AS seriesName, s.id_writer AS idWriter, s.id_serie AS idSerie "
					+ "FROM nttdata_mysql_serie s WHERE s.id_writer = " + queryResultWriters.getString("idWriter");

			// Mientras el escritor tenga más sagas, extraerá la información de la BBDD.
			final ResultSet queryResultSeries = sentenceSeries.executeQuery(querySeries);
			while (queryResultSeries.next()) {
				LOG.info("\t\tSaga: {}", queryResultSeries.getString("seriesName"));

				// Llamada al método que realizará las consultas sobre las libros de la saga.
				booksQuery(dbConnection, queryResultSeries);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 
	 * Metodo para realizar una consulta sobre los libros de cada saga.
	 * 
	 * @param dbConnection
	 * @param queryResultSeries
	 * @throws SQLException
	 * 
	 */
	private static void booksQuery(final Connection dbConnection, final ResultSet queryResultSeries) {

		try (final Statement sentenceBooks = dbConnection.createStatement()) {

			// Creación de la consulta sobre libros.
			final String queryBooks = "SELECT b.name AS bookName, b.release_date AS releaseDate, b.price AS price "
					+ "FROM nttdata_mysql_book b WHERE b.id_serie = " + queryResultSeries.getString("idSerie");
			final ResultSet queryResultBooks = sentenceBooks.executeQuery(queryBooks);

			// Mientras la saga contenga más libros, seguirá obteniendo la información.
			while (queryResultBooks.next()) {
				LOG.info("\t\t\tLibro: {}", queryResultBooks.getString("bookName"));
				LOG.info("\t\t\t\tFecha de lanzamiento: {}", queryResultBooks.getDate("releaseDate"));
				LOG.info("\t\t\t\tPrecio: {}€", queryResultBooks.getString("price"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}