--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: articles; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE articles (
    id integer NOT NULL,
    title character varying(255),
    abstract text,
    url character varying(255),
    num_pages integer,
    edition_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: articles_authors; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE articles_authors (
    article_id integer,
    author_id integer
);


--
-- Name: articles_keywords; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE articles_keywords (
    article_id integer,
    keyword_id integer
);


--
-- Name: authors; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE authors (
    id integer NOT NULL,
    last_name character varying(255),
    first_name character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: keywords; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE keywords (
    id integer NOT NULL,
    kw_name character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: article_searches; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW article_searches AS
    (((SELECT articles.id AS searchable_id, 'Article'::text AS searchable_type, articles.title AS term FROM articles UNION SELECT articles.id AS searchable_id, 'Article'::text AS searchable_type, articles.abstract AS term FROM articles) UNION SELECT articles.id AS searchable_id, 'Article'::text AS searchable_type, authors.first_name AS term FROM ((articles_authors JOIN authors ON ((articles_authors.author_id = authors.id))) JOIN articles ON ((articles_authors.article_id = articles.id)))) UNION SELECT articles.id AS searchable_id, 'Article'::text AS searchable_type, authors.last_name AS term FROM ((articles_authors JOIN authors ON ((articles_authors.author_id = authors.id))) JOIN articles ON ((articles_authors.article_id = articles.id)))) UNION SELECT articles.id AS searchable_id, 'Article'::text AS searchable_type, keywords.kw_name AS term FROM ((articles_keywords JOIN keywords ON ((articles_keywords.keyword_id = keywords.id))) JOIN articles ON ((articles_keywords.article_id = articles.id)));


--
-- Name: articles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE articles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: articles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE articles_id_seq OWNED BY articles.id;


--
-- Name: authors_books; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE authors_books (
    book_id integer,
    author_id integer
);


--
-- Name: authors_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE authors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: authors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE authors_id_seq OWNED BY authors.id;


--
-- Name: books; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE books (
    id integer NOT NULL,
    title character varying(255),
    abstract text,
    url character varying(255),
    num_pages integer,
    edition_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: book_searches; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW book_searches AS
    (SELECT books.id AS searchable_id, 'Book'::text AS searchable_type, books.title AS term FROM books UNION SELECT books.id AS searchable_id, 'Book'::text AS searchable_type, books.abstract AS term FROM books) UNION SELECT books.id AS searchable_id, 'Book'::text AS searchable_type, authors.first_name AS term FROM ((authors_books JOIN books ON ((authors_books.book_id = books.id))) JOIN authors ON ((authors_books.author_id = authors.id)));


--
-- Name: books_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE books_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: books_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE books_id_seq OWNED BY books.id;


--
-- Name: books_keywords; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE books_keywords (
    book_id integer,
    keyword_id integer
);


--
-- Name: editions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE editions (
    id integer NOT NULL,
    e_name character varying(255),
    e_date date,
    journal_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: editions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE editions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: editions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE editions_id_seq OWNED BY editions.id;


--
-- Name: journals; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE journals (
    id integer NOT NULL,
    j_name character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: journals_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE journals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: journals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE journals_id_seq OWNED BY journals.id;


--
-- Name: keywords_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE keywords_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: keywords_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE keywords_id_seq OWNED BY keywords.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    name character varying(255),
    email character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    password_digest character varying(255),
    remember_token character varying(255),
    admin boolean DEFAULT false
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY articles ALTER COLUMN id SET DEFAULT nextval('articles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY authors ALTER COLUMN id SET DEFAULT nextval('authors_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY books ALTER COLUMN id SET DEFAULT nextval('books_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY editions ALTER COLUMN id SET DEFAULT nextval('editions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY journals ALTER COLUMN id SET DEFAULT nextval('journals_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY keywords ALTER COLUMN id SET DEFAULT nextval('keywords_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: articles_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY articles
    ADD CONSTRAINT articles_pkey PRIMARY KEY (id);


--
-- Name: authors_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY authors
    ADD CONSTRAINT authors_pkey PRIMARY KEY (id);


--
-- Name: books_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY books
    ADD CONSTRAINT books_pkey PRIMARY KEY (id);


--
-- Name: editions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY editions
    ADD CONSTRAINT editions_pkey PRIMARY KEY (id);


--
-- Name: journals_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY journals
    ADD CONSTRAINT journals_pkey PRIMARY KEY (id);


--
-- Name: keywords_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY keywords
    ADD CONSTRAINT keywords_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_articles_on_abstract; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_articles_on_abstract ON articles USING gin (to_tsvector('english'::regconfig, abstract));


--
-- Name: index_articles_on_title; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_articles_on_title ON articles USING gin (to_tsvector('english'::regconfig, (title)::text));


--
-- Name: index_authors_on_first_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_authors_on_first_name ON authors USING gin (to_tsvector('english'::regconfig, (first_name)::text));


--
-- Name: index_authors_on_last_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_authors_on_last_name ON authors USING gin (to_tsvector('english'::regconfig, (last_name)::text));


--
-- Name: index_books_on_abstract; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_books_on_abstract ON books USING gin (to_tsvector('english'::regconfig, abstract));


--
-- Name: index_books_on_title; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_books_on_title ON books USING gin (to_tsvector('english'::regconfig, (title)::text));


--
-- Name: index_keywords_on_kw_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_keywords_on_kw_name ON keywords USING gin (to_tsvector('english'::regconfig, (kw_name)::text));


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_remember_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_on_remember_token ON users USING btree (remember_token);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: fk_articles_authors_articles; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY articles_authors
    ADD CONSTRAINT fk_articles_authors_articles FOREIGN KEY (article_id) REFERENCES articles(id);


--
-- Name: fk_articles_authors_authors; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY articles_authors
    ADD CONSTRAINT fk_articles_authors_authors FOREIGN KEY (author_id) REFERENCES authors(id);


--
-- Name: fk_articles_editions; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY articles
    ADD CONSTRAINT fk_articles_editions FOREIGN KEY (edition_id) REFERENCES editions(id);


--
-- Name: fk_articles_keywords_articles; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY articles_keywords
    ADD CONSTRAINT fk_articles_keywords_articles FOREIGN KEY (article_id) REFERENCES articles(id);


--
-- Name: fk_articles_keywords_keywords; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY articles_keywords
    ADD CONSTRAINT fk_articles_keywords_keywords FOREIGN KEY (keyword_id) REFERENCES keywords(id);


--
-- Name: fk_editions_journals; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY editions
    ADD CONSTRAINT fk_editions_journals FOREIGN KEY (journal_id) REFERENCES journals(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20131208172654');

INSERT INTO schema_migrations (version) VALUES ('20131208172758');

INSERT INTO schema_migrations (version) VALUES ('20131208173039');

INSERT INTO schema_migrations (version) VALUES ('20131210195502');

INSERT INTO schema_migrations (version) VALUES ('20131210200431');

INSERT INTO schema_migrations (version) VALUES ('20140508175946');

INSERT INTO schema_migrations (version) VALUES ('20140508181034');

INSERT INTO schema_migrations (version) VALUES ('20140508181817');

INSERT INTO schema_migrations (version) VALUES ('20140508184125');

INSERT INTO schema_migrations (version) VALUES ('20140509232221');

INSERT INTO schema_migrations (version) VALUES ('20140509233158');

INSERT INTO schema_migrations (version) VALUES ('20140510000633');

INSERT INTO schema_migrations (version) VALUES ('20140510001216');

INSERT INTO schema_migrations (version) VALUES ('20140510002241');

INSERT INTO schema_migrations (version) VALUES ('20140513190648');

INSERT INTO schema_migrations (version) VALUES ('20140513191114');

INSERT INTO schema_migrations (version) VALUES ('20140513191535');

INSERT INTO schema_migrations (version) VALUES ('20140513204507');

INSERT INTO schema_migrations (version) VALUES ('20140514002322');

INSERT INTO schema_migrations (version) VALUES ('20140515214211');

INSERT INTO schema_migrations (version) VALUES ('20140515215505');

INSERT INTO schema_migrations (version) VALUES ('20140515220403');

INSERT INTO schema_migrations (version) VALUES ('20140515221220');

INSERT INTO schema_migrations (version) VALUES ('20140516043306');
