package com.womenwhocode.tokyo.event

import com.nhaarman.mockitokotlin2.whenever
import com.womenwhocode.tokyo.meetupapi.EventType.PAST
import com.womenwhocode.tokyo.meetupapi.EventType.UPCOMING
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
import java.time.LocalDateTime

@WebMvcTest
class EventControllerTest {
    @Autowired
    private lateinit var mvc: MockMvc

    @MockBean
    private lateinit var service: EventService

    @BeforeEach
    internal fun setUp() {
        val eventVenue = WWCEvent.Venue(
            "venue name",
            WWCEvent.Location(1.23, 4.56, "venue address", "Tokyo")
        )

        val upcomingEvents = listOf(
            WWCEvent(
                "1",
                "WTF is JavaScript?! Talk + Workshop for Beginners with WWCode & Automattic",
                LocalDateTime.of(2020, 6, 2, 19, 30),
                LocalDateTime.of(2020, 6, 2, 21, 30),
                "What is this upcoming event about",
                eventVenue,
                "upcoming-example.com"
            )
        )

        val pastEvents = listOf(
            WWCEvent(
                "2",
                "Past Event",
                LocalDateTime.of(2019, 4, 1, 19, 0),
                LocalDateTime.of(2019, 4, 1, 21, 0),
                "What is this past event about",
                eventVenue,
                "past-example.com"
            )
        )

        whenever(service.getEvents(UPCOMING)).thenReturn(upcomingEvents)
        whenever(service.getEvents(PAST)).thenReturn(pastEvents)
    }

    @Test
    fun `get upcoming events returns 200`() {
        mvc.perform(
            MockMvcRequestBuilders
                .get("/api/events/upcoming")
                .accept(MediaType.APPLICATION_JSON)
        )
            .andExpect(status().isOk())
    }

    @Test
    fun `get upcoming events returns upcoming events`() {
        mvc.perform(
            MockMvcRequestBuilders
                .get("/api/events/upcoming")
                .accept(MediaType.APPLICATION_JSON)
        )
            .andExpect(jsonPath("$").isArray)
            .andExpect(jsonPath("$[0].id", `is`("1")))
            .andExpect(
                jsonPath(
                    "$[0].name",
                    `is`("WTF is JavaScript?! Talk + Workshop for Beginners with WWCode & Automattic")
                )
            )
            .andExpect(jsonPath("$[0].startDateTime", `is`("2020-06-02T19:30:00")))
            .andExpect(jsonPath("$[0].endDateTime", `is`("2020-06-02T21:30:00")))
            .andExpect(jsonPath("$[0].description", `is`("What is this upcoming event about")))
            .andExpect(jsonPath("$[0].link", `is`("upcoming-example.com")))
            .andExpect(jsonPath("$[0].venue.name", `is`("venue name")))
            .andExpect(jsonPath("$[0].venue.location.lat", `is`(1.23)))
            .andExpect(jsonPath("$[0].venue.location.lon", `is`(4.56)))
            .andExpect(jsonPath("$[0].venue.location.address", `is`("venue address")))
            .andExpect(jsonPath("$[0].venue.location.city", `is`("Tokyo")))

    }

    @Test
    fun `get past events returns 200`() {
        mvc.perform(
            MockMvcRequestBuilders
                .get("/api/events/past")
                .accept(MediaType.APPLICATION_JSON)
        )
            .andExpect(status().isOk())
    }

    @Test
    fun `get past events returns past events`() {
        mvc.perform(
            MockMvcRequestBuilders
                .get("/api/events/past")
                .accept(MediaType.APPLICATION_JSON)
        )
            .andExpect(jsonPath("$").isArray)
            .andExpect(jsonPath("$[0].id", `is`("2")))
            .andExpect(jsonPath("$[0].name", `is`("Past Event")))
            .andExpect(jsonPath("$[0].startDateTime", `is`("2019-04-01T19:00:00")))
            .andExpect(jsonPath("$[0].endDateTime", `is`("2019-04-01T21:00:00")))
            .andExpect(jsonPath("$[0].description", `is`("What is this past event about")))
            .andExpect(jsonPath("$[0].link", `is`("past-example.com")))
            .andExpect(jsonPath("$[0].venue.name", `is`("venue name")))
            .andExpect(jsonPath("$[0].venue.location.lat", `is`(1.23)))
            .andExpect(jsonPath("$[0].venue.location.lon", `is`(4.56)))
            .andExpect(jsonPath("$[0].venue.location.address", `is`("venue address")))
            .andExpect(jsonPath("$[0].venue.location.city", `is`("Tokyo")))
    }
}