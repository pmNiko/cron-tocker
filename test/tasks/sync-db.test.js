const { syncDB } = require("../../tasks/sync-db");

describe("Pruebas en Sync-DB", () => {
  test("Debe ejecutar dos veces el proceso", () => {
    syncDB();
    const times = syncDB();

    expect(times).toBe(2);
  });
});
