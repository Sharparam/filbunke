// Entry point for the build script in your package.json
import "@hotwired/turbo-rails";
import "./controllers";
import * as bootstrap from "bootstrap";

document.addEventListener("DOMContentLoaded", () => {
  const tt_elems = document.querySelectorAll('[data-bs-toggle="tooltip"]');
  for (const elem of tt_elems) {
    new bootstrap.Tooltip(elem);
  }
});
