// Sonic 3D Project – base script

console.log("Sonic 3D environment loaded ⚡");

// Exemplo simples de interação
document.addEventListener("DOMContentLoaded", () => {
  const title = document.querySelector("h1");

  title.addEventListener("mouseenter", () => {
    title.style.transform = "scale(1.1)";
  });

  title.addEventListener("mouseleave", () => {
    title.style.transform = "scale(1)";
  });
});
