package com.gft.first.microservice_consul_1;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;


import static org.assertj.core.api.Assertions.assertThat;

@RunWith(SpringRunner.class)
@SpringBootTest(classes = MicroserviceConsul1Application.class)
@WebAppConfiguration
public class MicroserviceConsul1ApplicationTests {

	@Autowired
	private WebApplicationContext webAppContext;

	private MockMvc mockMvc;

	@Before
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(webAppContext).build();
	}

	@Test
	public void testHelloWorldEndpoint() throws Exception {
		MvcResult result = this.mockMvc.perform(MockMvcRequestBuilders.get("/")).andReturn();
		MockHttpServletResponse response = result.getResponse();

		assertThat(response.getContentAsString()).contains("Hello");
	}

	@Test
	public void getHtmlValueFromContrller() throws Exception {
		MvcResult result = this.mockMvc.perform(MockMvcRequestBuilders.get("/api/inspect?format=html")).andReturn();
		MockHttpServletResponse response = result.getResponse();

		assertThat(response.getContentAsString()).contains("</b><br/>Your current IP address : <b>");
	}
	@Test
	public void getCsvValueFromContrller() throws Exception {
		MvcResult result = this.mockMvc.perform(MockMvcRequestBuilders.get("/api/inspect?format=csv")).andReturn();
		MockHttpServletResponse response = result.getResponse();

		assertThat(response.getContentAsString()).contains( "Application name\":\"u-service-hello-app", "Your current IP address\"");
	}
}
