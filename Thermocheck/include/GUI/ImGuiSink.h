#ifndef IMGUI_SINK_H
#define IMGUI_SINK_H

#include "GUI/ImGuiConsole.h"

#include <spdlog/sinks/base_sink.h>

template<typename Mutex>
class ImGuiSink : public spdlog::sinks::base_sink<Mutex> {
public:

	ImGuiSink() = default;
	
	ImGuiSink(const ImGuiSink&)            = delete;
	ImGuiSink& operator=(const ImGuiSink&) = delete;

protected:

	void sink_it_(const spdlog::details::log_msg& msg) override {
		spdlog::memory_buf_t formatted;
		spdlog::sinks::base_sink<Mutex>::formatter_->format(msg, formatted);
		ImGuiConsole::sink({ fmt::to_string(formatted), msg.level });
	}
	
	void flush_() override {}
	
};

using ImGuiSinkMT = ImGuiSink<std::mutex>;
using ImGuiSinkST = ImGuiSink<spdlog::details::null_mutex>;

#endif
