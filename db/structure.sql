SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: active_storage_attachments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.active_storage_attachments (
    id bigint NOT NULL,
    name character varying NOT NULL,
    record_type character varying NOT NULL,
    record_id bigint NOT NULL,
    blob_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL
);


--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.active_storage_attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.active_storage_attachments_id_seq OWNED BY public.active_storage_attachments.id;


--
-- Name: active_storage_blobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.active_storage_blobs (
    id bigint NOT NULL,
    key character varying NOT NULL,
    filename character varying NOT NULL,
    content_type character varying,
    metadata text,
    byte_size bigint NOT NULL,
    checksum character varying NOT NULL,
    created_at timestamp without time zone NOT NULL
);


--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.active_storage_blobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.active_storage_blobs_id_seq OWNED BY public.active_storage_blobs.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: content_sources; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.content_sources (
    id bigint NOT NULL,
    guid character varying NOT NULL,
    name character varying NOT NULL,
    region character varying NOT NULL,
    state character varying NOT NULL,
    twitter character varying,
    site text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    source_type character varying NOT NULL,
    source_scope character varying NOT NULL,
    logo_url character varying,
    cloudinary_image_id character varying
);


--
-- Name: content_sources_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.content_sources_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: content_sources_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.content_sources_id_seq OWNED BY public.content_sources.id;


--
-- Name: content_texts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.content_texts (
    id bigint NOT NULL,
    content_id bigint NOT NULL,
    excerpt text,
    full_text_hash character varying NOT NULL,
    full_text text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: content_texts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.content_texts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: content_texts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.content_texts_id_seq OWNED BY public.content_texts.id;


--
-- Name: contents; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contents (
    id bigint NOT NULL,
    content_source_id bigint NOT NULL,
    uuid character varying NOT NULL,
    content_type character varying NOT NULL,
    found_at timestamp without time zone NOT NULL,
    published_at timestamp without time zone NOT NULL,
    modified_at timestamp without time zone,
    image_url text,
    title character varying,
    display_text character varying NOT NULL,
    url_hash character varying NOT NULL,
    url text NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    cloudinary_image_id character varying,
    extra_data jsonb DEFAULT '{}'::jsonb NOT NULL
);


--
-- Name: contents_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.contents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: contents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.contents_id_seq OWNED BY public.contents.id;


--
-- Name: inputs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.inputs (
    id bigint NOT NULL,
    uuid character varying NOT NULL,
    key character varying NOT NULL,
    found_at timestamp without time zone NOT NULL,
    content_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    scraped_content_id bigint
);


--
-- Name: inputs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.inputs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: inputs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.inputs_id_seq OWNED BY public.inputs.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: scraped_contents; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.scraped_contents (
    id bigint NOT NULL,
    content_source_id bigint NOT NULL,
    content_id bigint,
    content_type character varying NOT NULL,
    first_seen_at timestamp without time zone NOT NULL,
    last_seen_at timestamp without time zone NOT NULL,
    detected_removal_at timestamp without time zone,
    url_hash character varying,
    url text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    published_at timestamp without time zone
);


--
-- Name: scraped_contents_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.scraped_contents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: scraped_contents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.scraped_contents_id_seq OWNED BY public.scraped_contents.id;


--
-- Name: search_documents; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.search_documents (
    id bigint NOT NULL,
    content_source_id bigint NOT NULL,
    content_id bigint NOT NULL,
    content_type character varying NOT NULL,
    state character varying NOT NULL,
    title character varying,
    excerpt text,
    full_text text NOT NULL,
    published_at timestamp without time zone NOT NULL,
    searchable tsvector GENERATED ALWAYS AS (((to_tsvector('portuguese'::regconfig, (COALESCE(title, ''::character varying))::text) || to_tsvector('portuguese'::regconfig, COALESCE(excerpt, ''::text))) || to_tsvector('portuguese'::regconfig, COALESCE(full_text, ''::text)))) STORED,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: search_documents_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.search_documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: search_documents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.search_documents_id_seq OWNED BY public.search_documents.id;


--
-- Name: active_storage_attachments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_attachments ALTER COLUMN id SET DEFAULT nextval('public.active_storage_attachments_id_seq'::regclass);


--
-- Name: active_storage_blobs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_blobs ALTER COLUMN id SET DEFAULT nextval('public.active_storage_blobs_id_seq'::regclass);


--
-- Name: content_sources id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.content_sources ALTER COLUMN id SET DEFAULT nextval('public.content_sources_id_seq'::regclass);


--
-- Name: content_texts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.content_texts ALTER COLUMN id SET DEFAULT nextval('public.content_texts_id_seq'::regclass);


--
-- Name: contents id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contents ALTER COLUMN id SET DEFAULT nextval('public.contents_id_seq'::regclass);


--
-- Name: inputs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inputs ALTER COLUMN id SET DEFAULT nextval('public.inputs_id_seq'::regclass);


--
-- Name: scraped_contents id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scraped_contents ALTER COLUMN id SET DEFAULT nextval('public.scraped_contents_id_seq'::regclass);


--
-- Name: search_documents id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.search_documents ALTER COLUMN id SET DEFAULT nextval('public.search_documents_id_seq'::regclass);


--
-- Name: active_storage_attachments active_storage_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT active_storage_attachments_pkey PRIMARY KEY (id);


--
-- Name: active_storage_blobs active_storage_blobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_blobs
    ADD CONSTRAINT active_storage_blobs_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: content_sources content_sources_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.content_sources
    ADD CONSTRAINT content_sources_pkey PRIMARY KEY (id);


--
-- Name: content_texts content_texts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.content_texts
    ADD CONSTRAINT content_texts_pkey PRIMARY KEY (id);


--
-- Name: contents contents_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contents
    ADD CONSTRAINT contents_pkey PRIMARY KEY (id);


--
-- Name: inputs inputs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inputs
    ADD CONSTRAINT inputs_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: scraped_contents scraped_contents_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scraped_contents
    ADD CONSTRAINT scraped_contents_pkey PRIMARY KEY (id);


--
-- Name: search_documents search_documents_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.search_documents
    ADD CONSTRAINT search_documents_pkey PRIMARY KEY (id);


--
-- Name: index_active_storage_attachments_on_blob_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_active_storage_attachments_on_blob_id ON public.active_storage_attachments USING btree (blob_id);


--
-- Name: index_active_storage_attachments_uniqueness; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_active_storage_attachments_uniqueness ON public.active_storage_attachments USING btree (record_type, record_id, name, blob_id);


--
-- Name: index_active_storage_blobs_on_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_active_storage_blobs_on_key ON public.active_storage_blobs USING btree (key);


--
-- Name: index_content_sources_on_guid; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_content_sources_on_guid ON public.content_sources USING btree (guid);


--
-- Name: index_content_sources_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_content_sources_on_name ON public.content_sources USING btree (name);


--
-- Name: index_content_sources_on_region; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_content_sources_on_region ON public.content_sources USING btree (region);


--
-- Name: index_content_sources_on_state; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_content_sources_on_state ON public.content_sources USING btree (state);


--
-- Name: index_content_texts_on_content_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_content_texts_on_content_id ON public.content_texts USING btree (content_id);


--
-- Name: index_content_texts_on_full_text_hash; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_content_texts_on_full_text_hash ON public.content_texts USING btree (full_text_hash);


--
-- Name: index_contents_on_content_source_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_contents_on_content_source_id ON public.contents USING btree (content_source_id);


--
-- Name: index_contents_on_content_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_contents_on_content_type ON public.contents USING btree (content_type);


--
-- Name: index_contents_on_found_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_contents_on_found_at ON public.contents USING btree (found_at);


--
-- Name: index_contents_on_published_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_contents_on_published_at ON public.contents USING btree (published_at);


--
-- Name: index_contents_on_url_hash; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_contents_on_url_hash ON public.contents USING btree (url_hash);


--
-- Name: index_contents_on_uuid; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_contents_on_uuid ON public.contents USING btree (uuid);


--
-- Name: index_inputs_on_content_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_inputs_on_content_id ON public.inputs USING btree (content_id);


--
-- Name: index_inputs_on_key_and_found_at; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_inputs_on_key_and_found_at ON public.inputs USING btree (key, found_at);


--
-- Name: index_inputs_on_scraped_content_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_inputs_on_scraped_content_id ON public.inputs USING btree (scraped_content_id);


--
-- Name: index_inputs_on_uuid; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_inputs_on_uuid ON public.inputs USING btree (uuid);


--
-- Name: index_scraped_contents_on_content_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_scraped_contents_on_content_id ON public.scraped_contents USING btree (content_id);


--
-- Name: index_scraped_contents_on_content_source_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_scraped_contents_on_content_source_id ON public.scraped_contents USING btree (content_source_id);


--
-- Name: index_scraped_contents_on_content_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_scraped_contents_on_content_type ON public.scraped_contents USING btree (content_type);


--
-- Name: index_scraped_contents_on_url_hash; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_scraped_contents_on_url_hash ON public.scraped_contents USING btree (url_hash);


--
-- Name: index_search_documents_on_content_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_search_documents_on_content_id ON public.search_documents USING btree (content_id);


--
-- Name: index_search_documents_on_content_source_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_search_documents_on_content_source_id ON public.search_documents USING btree (content_source_id);


--
-- Name: index_search_documents_on_published_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_search_documents_on_published_at ON public.search_documents USING btree (published_at);


--
-- Name: index_search_documents_on_searchable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_search_documents_on_searchable ON public.search_documents USING gin (searchable);


--
-- Name: index_search_documents_on_state_and_published_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_search_documents_on_state_and_published_at ON public.search_documents USING btree (state, published_at);


--
-- Name: inputs fk_rails_03e8e7074d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inputs
    ADD CONSTRAINT fk_rails_03e8e7074d FOREIGN KEY (scraped_content_id) REFERENCES public.scraped_contents(id);


--
-- Name: scraped_contents fk_rails_058147077d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scraped_contents
    ADD CONSTRAINT fk_rails_058147077d FOREIGN KEY (content_source_id) REFERENCES public.content_sources(id);


--
-- Name: scraped_contents fk_rails_0d91515e7b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scraped_contents
    ADD CONSTRAINT fk_rails_0d91515e7b FOREIGN KEY (content_id) REFERENCES public.contents(id);


--
-- Name: search_documents fk_rails_4f31f235e5; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.search_documents
    ADD CONSTRAINT fk_rails_4f31f235e5 FOREIGN KEY (content_id) REFERENCES public.contents(id);


--
-- Name: contents fk_rails_60f0481291; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contents
    ADD CONSTRAINT fk_rails_60f0481291 FOREIGN KEY (content_source_id) REFERENCES public.content_sources(id);


--
-- Name: inputs fk_rails_88449bda1e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inputs
    ADD CONSTRAINT fk_rails_88449bda1e FOREIGN KEY (content_id) REFERENCES public.contents(id);


--
-- Name: content_texts fk_rails_9f1ebeca8f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.content_texts
    ADD CONSTRAINT fk_rails_9f1ebeca8f FOREIGN KEY (content_id) REFERENCES public.contents(id);


--
-- Name: search_documents fk_rails_c1e9d05775; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.search_documents
    ADD CONSTRAINT fk_rails_c1e9d05775 FOREIGN KEY (content_source_id) REFERENCES public.content_sources(id);


--
-- Name: active_storage_attachments fk_rails_c3b3935057; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT fk_rails_c3b3935057 FOREIGN KEY (blob_id) REFERENCES public.active_storage_blobs(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20200422221908'),
('20200423032426'),
('20200428212854'),
('20200428213739'),
('20200430225140'),
('20200501224941'),
('20200511012600'),
('20200513181835'),
('20200513202109'),
('20200515224605'),
('20200516021928');


