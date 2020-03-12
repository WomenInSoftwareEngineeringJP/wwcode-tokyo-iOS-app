package com.womenwhocode.tokyo.event

import com.nhaarman.mockitokotlin2.whenever
import com.womenwhocode.tokyo.meetupapi.EventType.*
import org.hamcrest.Matchers.`is`
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest
import org.springframework.boot.test.mock.mockito.MockBean
import org.springframework.http.MediaType
import org.springframework.test.web.servlet.MockMvc
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders
import org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath
import org.springframework.test.web.servlet.result.MockMvcResultMatchers.status

@WebMvcTest
class EventControllerTest {

    @Autowired
    private lateinit var mvc: MockMvc

    @MockBean
    private lateinit var service: EventService

    @BeforeEach
    internal fun setUp() {
        val upcomingEvents = listOf(
                WWCEvent(
                        "WTF is JavaScript?! Talk + Workshop for Beginners with WWCode & Automattic",
                        "Jun 2, Wed",
                        "19:30-21:30",
                        "Code Chrysalis"))

        val pastEvents = listOf(
                WWCEvent(
                        "Past Event",
                        "Feb 2, Wed",
                        "18:00-21:30",
                        "Mercari"))

        whenever(service.getEvents(UPCOMING)).thenReturn(upcomingEvents)
        whenever(service.getEvents(PAST)).thenReturn(pastEvents)
    }

    @Test
    fun `get upcoming events returns 200`() {
        mvc.perform(MockMvcRequestBuilders
                .get("/api/events/upcoming")
                .accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
    }

    @Test
    fun `get upcoming events returns upcoming events`() {
        mvc.perform(MockMvcRequestBuilders
                .get("/api/events/upcoming")
                .accept(MediaType.APPLICATION_JSON))
                .andExpect(jsonPath("$").isArray)
                .andExpect(jsonPath("$[0].name", `is`("WTF is JavaScript?! Talk + Workshop for Beginners with WWCode & Automattic")))
                .andExpect(jsonPath("$[0].date", `is`("Jun 2, Wed")))
                .andExpect(jsonPath("$[0].time", `is`("19:30-21:30")))
                .andExpect(jsonPath("$[0].venueName", `is`("Code Chrysalis")))
    }
    @Test
    fun `get past events returns 200`() {
        mvc.perform(MockMvcRequestBuilders
                .get("/api/events/past")
                .accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
    }

    @Test
    fun `get past events returns past events`() {
        mvc.perform(MockMvcRequestBuilders
                .get("/api/events/past")
                .accept(MediaType.APPLICATION_JSON))
                .andExpect(jsonPath("$").isArray)
                .andExpect(jsonPath("$[0].name", `is`("Past Event")))
                .andExpect(jsonPath("$[0].date", `is`("Feb 2, Wed")))
                .andExpect(jsonPath("$[0].time", `is`("18:00-21:30")))
                .andExpect(jsonPath("$[0].venueName", `is`("Mercari")))
    }
}