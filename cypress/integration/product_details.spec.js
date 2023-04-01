describe('Jungle App', () => {
  beforeEach(() => {
    cy.visit('http://127.0.0.1:40137/')
  })

  it("There are 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });
  
  it("Can look at a product's details", () => {
    cy.contains('Scented Blade').click()
    cy.contains("The Scented Blade is an extremely rare, tall plant and can be found mostly in savannas. It blooms once a year, for 2 weeks.").should('exist')
  });
})