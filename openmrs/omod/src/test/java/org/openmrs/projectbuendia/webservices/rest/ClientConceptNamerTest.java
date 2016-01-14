package org.openmrs.projectbuendia.webservices.rest;

// Copyright 2015 The Project Buendia Authors
//
// Licensed under the Apache License, Version 2.0 (the "License"); you may not
// use this file except in compliance with the License.  You may obtain a copy
// of the License at: http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software distrib-
// uted under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES
// OR CONDITIONS OF ANY KIND, either express or implied.  See the License for
// specific language governing permissions and limitations under the License.

import org.junit.Test;
import org.openmrs.Concept;
import org.openmrs.ConceptName;
import org.openmrs.projectbuendia.ClientConceptNamer;

import java.util.Arrays;
import java.util.Locale;

import static org.junit.Assert.assertEquals;

/** Unit tests for ClientConceptNamer. */
public class ClientConceptNamerTest {
    @Test
    public void testConceptNameFailoverToDefault() {
        Concept concept = new Concept();
        ConceptName en = makePreferred("name en", ClientConceptNamer.DEFAULT);
        concept.setNames(Arrays.asList(en));
        String name = new ClientConceptNamer(new Locale("fr")).getClientName(concept);
        assertEquals("name en", name);
    }

    private ConceptName makePreferred(String s, Locale l) {
        ConceptName enClient = new ConceptName(s, l);
        enClient.setLocalePreferred(true);
        return enClient;
    }

    @Test
    public void testConceptNameFailoverToDefaultClient() {
        Concept concept = new Concept();
        ConceptName en = makePreferred("name en", ClientConceptNamer.DEFAULT);
        ConceptName enClient = makePreferred("name en client", ClientConceptNamer.DEFAULT_CLIENT);
        concept.setNames(Arrays.asList(en, enClient));
        String name = new ClientConceptNamer(new Locale("fr")).getClientName(concept);
        assertEquals("name en client", name);
    }

    @Test
    public void testConceptNameFailoverToClientInLocale() {
        Concept concept = new Concept();
        ConceptName en = makePreferred("name en", ClientConceptNamer.DEFAULT);
        ConceptName enClient = makePreferred("name en client", ClientConceptNamer.DEFAULT_CLIENT);
        ConceptName frClient = makePreferred("name fr client", new Locale.Builder()
            .setLanguage("fr")
            .setRegion(ClientConceptNamer.CLIENT_REGION)
            .setVariant(ClientConceptNamer.VARIANT)
            .build());
        concept.setNames(Arrays.asList(en, enClient, frClient));
        String name = new ClientConceptNamer(new Locale("fr")).getClientName(concept);
        assertEquals("name fr client", name);
    }

    @Test
    public void testConceptNameFailoverToLocaleClientWhenLocaleDefaultPresent() {
        Concept concept = new Concept();
        ConceptName en = makePreferred("name en", ClientConceptNamer.DEFAULT);
        ConceptName enClient = makePreferred("name en client", ClientConceptNamer.DEFAULT_CLIENT);
        ConceptName fr = makePreferred("name fr", new Locale("fr"));
        ConceptName frClient = makePreferred("name fr client", new Locale.Builder()
            .setLanguage("fr")
            .setRegion(ClientConceptNamer.CLIENT_REGION)
            .setVariant(ClientConceptNamer.VARIANT)
            .build());
        concept.setNames(Arrays.asList(en, enClient, fr, frClient));
        String name = new ClientConceptNamer(new Locale("fr")).getClientName(concept);
        assertEquals("name fr client", name);
    }

    @Test
    public void testConceptNameFailoverToLocaleDefaultWhenNoLocaleDefault() {
        Concept concept = new Concept();
        ConceptName en = makePreferred("name en", ClientConceptNamer.DEFAULT);
        ConceptName enClient = makePreferred("name en client", ClientConceptNamer.DEFAULT_CLIENT);
        ConceptName fr = makePreferred("name fr", new Locale("fr"));
        concept.setNames(Arrays.asList(en, enClient, fr));
        String name = new ClientConceptNamer(new Locale("fr")).getClientName(concept);
        assertEquals("name fr", name);
    }
}
