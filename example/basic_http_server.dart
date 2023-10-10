import 'package:calendar_basic/calendar_basic.dart';
import 'package:intl/intl.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;

const appScopeId = "app";

const headTag = """
  <!DOCTYPE html>
  <head>
    <script src="https://unpkg.com/htmx.org@1.9.6" integrity="sha384-FhXw7b6AlE/jyjlZH5iHa/tTe9EpJ1Y55RjcgPbjeWMskSxZt1v9qkxLJWNJaGni" crossorigin="anonymous"></script>
    <script src="https://cdn.tailwindcss.com"></script>
  </head>
  """;

const headers = {'Content-Type': 'text/html; charset=utf-8'};

String backgroundHTML(String content) {
  return """
  <div id="$appScopeId" class="flex flex-col space-y-12 items-center justify-center bg-[conic-gradient(at_top,_var(--tw-gradient-stops))] from-indigo-300 to-purple-400 w-screen h-screen">
    <h1 class="text-5xl">Basic Calendar 📅</h1>
    $content
  </div>
  """;
}

String calendarShellHTML(String content, BasicCalendar calendar) {
  return """
    <div class="bg-purple-200 h-96 w-96 rounded-xl flex flex-col items-center shadow-xl">
        <div class="flex space-x-4 items-center w-full p-4">
          <button class="bg-purple-400 text-white rounded-lg p-2"
             hx-post="/prev_month"
             hx-trigger="click"
             hx-target="#$appScopeId"
             hx-swap="outerHTML"
          >
            PREV
          </button>
          <h3 class="text-xl flex-grow text-center">${DateFormat('d MMMM yyyy').format(calendar.currentDate)}</h3>
          <button class="bg-purple-400 text-white rounded-lg p-2"
            hx-post="/next_month"
            hx-trigger="click"
            hx-target="#$appScopeId"
            hx-swap="outerHTML"
          >
            NEXT
          </button>
        </div>
        $content
    </div>
  """;
}

String daysHTML(String content, BasicCalendar calendar) {
  final dayOfMonth = calendar.daysOfMonth;
  return """
    <div class="grid grid-cols-7 grid-row-7 w-full h-full p-4">
      <div class="w-full h-full flex items-center justify-center">L</div>
      <div class="w-full h-full flex items-center justify-center">Ma</div>
      <div class="w-full h-full flex items-center justify-center">Me</div>
      <div class="w-full h-full flex items-center justify-center">J</div>
      <div class="w-full h-full flex items-center justify-center">V</div>
      <div class="w-full h-full flex items-center justify-center">S</div>
      <div class="w-full h-full flex items-center justify-center">D</div>
      ${List.generate(dayOfMonth.first.weekday - 1, (_) => """<div></div>""").join("\n")}
      ${dayOfMonth.map((day) {
    final isSelectedDay = day.isAtSameMomentAs(calendar.currentDate);
    return """
    <div 
    class='w-full h-full flex items-center justify-center cursor-pointer rounded-lg ${isSelectedDay ? 'bg-purple-400' : ''}'
      hx-post="/select_day/${day.toIso8601String()}"
      hx-trigger="click"
      hx-target="#$appScopeId"
      hx-swap="outerHTML"
    >
    ${day.day}
    </div>
    """;
  }).join("\n")}
    </div>
  """;
}

String pageHtml(BasicCalendar calendar) {
  return """
    $headTag
    ${backgroundHTML(
    calendarShellHTML(daysHTML("", calendar), calendar),
  )}
  """;
}

void main() async {
  final calendar = BasicCalendar();

  var app = Router();

  app.get('/', (Request request) {
    return Response.ok(
      pageHtml(calendar),
      headers: headers,
    );
  });

  app.post('/prev_month', (Request request) {
    calendar.selectPreviousMonth();
    return Response.ok(
      pageHtml(calendar),
      headers: headers,
    );
  });

  app.post('/next_month', (Request request) {
    calendar.selectNextMonth();
    return Response.ok(
      pageHtml(calendar),
      headers: headers,
    );
  });

  app.post('/select_day/<date>', (Request request, String date) {
    calendar.selectDate(DateTime.parse(date));
    return Response.ok(
      pageHtml(calendar),
      headers: headers,
    );
  });

  print('running htmx webserver on http://localhost:8080');
  await io.serve(app, 'localhost', 8080);
}
