package com.womenwhocode.tokyo.web

import org.hamcrest.Matchers.`is`
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import org.mockito.Mockito.`when`
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
    private lateinit var repository: MeetupEventRepository

    @BeforeEach
    internal fun setUp() {
        val events = listOf(
                Event("WTF is JavaScript?! Talk + Workshop for Beginners with WWCode & Automattic"))

        `when`(repository.getEvents()).thenReturn(events)
    }

    @Test
    fun `get events returns 200`() {
        mvc.perform(MockMvcRequestBuilders
                .get("/api/events")
                .accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
    }

    @Test
    fun `get events returns events`() {
        mvc.perform(MockMvcRequestBuilders
                .get("/api/events")
                .accept(MediaType.APPLICATION_JSON))
                .andExpect(jsonPath("$").isArray)
                .andExpect(jsonPath("$[0].name", `is`("WTF is JavaScript?! Talk + Workshop for Beginners with WWCode & Automattic")))
    }

}