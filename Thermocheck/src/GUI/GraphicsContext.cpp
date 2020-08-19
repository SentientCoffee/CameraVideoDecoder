#include "tcpch.h"
#include "GUI/GraphicsContext.h"

#include <glfw/glfw3.h>
#include <glad/glad.h>

static void glErrorCallback(GLenum source, GLenum type, GLuint id, GLenum severity, GLsizei length, const GLchar* message, const void* userParam) {
	if(id == 131169 || id == 131185 || id == 131218 || id == 131204) return;

	char buffer[9] = { '\0' };
	sprintf(buffer, "%.8x", id);

	std::string log = "OpenGL(" + std::to_string(id) + " = 0x" + std::string(buffer) + "): ";

	switch(type) {
		case GL_DEBUG_TYPE_ERROR:                    log += "ERROR";                break;
		case GL_DEBUG_TYPE_DEPRECATED_BEHAVIOR:      log += "DEPRECATED BEHAVIOUR"; break;
		case GL_DEBUG_TYPE_UNDEFINED_BEHAVIOR:       log += "UNDEFINED BEHAVIOUR";  break;
		case GL_DEBUG_TYPE_PORTABILITY:              log += "PORTABILITY ISSUE";    break;
		case GL_DEBUG_TYPE_PERFORMANCE:              log += "PERFORMANCE ISSUE";    break;
		case GL_DEBUG_TYPE_MARKER:                   log += "TYPE MARKER";          break;
		case GL_DEBUG_TYPE_PUSH_GROUP:               log += "PUSH GROUP";           break;
		case GL_DEBUG_TYPE_POP_GROUP:                log += "POP GROUP";            break;
		case GL_DEBUG_TYPE_OTHER:                    log += "OTHER";                break;
		default: break;
	}

	log += "\nSOURCE: ";
	switch(source) {
		case GL_DEBUG_SOURCE_API:                   log += "API";                  break;
		case GL_DEBUG_SOURCE_WINDOW_SYSTEM:         log += "Window system";        break;
		case GL_DEBUG_SOURCE_SHADER_COMPILER:       log += "Shader compiler";      break;
		case GL_DEBUG_SOURCE_THIRD_PARTY:           log += "Third party";          break;
		case GL_DEBUG_SOURCE_APPLICATION:           log += "Application";          break;
		case GL_DEBUG_SOURCE_OTHER:                 log += "Other";                break;
		default:                                                                   break;
	}

	log += " \nSEVERITY: ";
	switch(severity) {
		case GL_DEBUG_SEVERITY_HIGH:                log += "HIGH";                 break;
		case GL_DEBUG_SEVERITY_MEDIUM:              log += "MEDIUM";               break;
		case GL_DEBUG_SEVERITY_LOW:                 log += "LOW";                  break;
		case GL_DEBUG_SEVERITY_NOTIFICATION:        log += "NOTIFICATION";         break;
		default:                                                                   break;
	}

	log += "\n" + std::string(message);

	if(type == GL_DEBUG_TYPE_ERROR) {
		Logger::logAssert(type != GL_DEBUG_TYPE_ERROR, "{}", log);
	}
	else {
		switch(severity) {
			case GL_DEBUG_SEVERITY_HIGH:   Logger::error  ("{}", log); break;
			case GL_DEBUG_SEVERITY_MEDIUM: Logger::warning("{}", log); break;
			case GL_DEBUG_SEVERITY_LOW:    Logger::info   ("{}", log); break;
			default:                       Logger::trace  ("{}", log); break;
		}
	}
}

void GraphicsContext::init() {

	Logger::logAssert(gladLoadGLLoader(reinterpret_cast<GLADloadproc>(glfwGetProcAddress)), "Could not initialize GLAD!");

#if TC_DEBUG

	glEnable(GL_DEBUG_OUTPUT);
	glEnable(GL_DEBUG_OUTPUT_SYNCHRONOUS);
	glDebugMessageCallback(glErrorCallback, nullptr);
	glDebugMessageControl(GL_DONT_CARE, GL_DONT_CARE, GL_DONT_CARE, 0, nullptr, GL_TRUE);

#endif
	
	Logger::info("OpenGL version: {}", glGetString(GL_VERSION));
	Logger::info("GLSL version: {}", glGetString(GL_SHADING_LANGUAGE_VERSION));
	Logger::info("Using {} {}"
		"\n----------------------------------------------------------------------------------------------------",
		glGetString(GL_VENDOR), glGetString(GL_RENDERER));
}
