describe('Jungle App', () => {
  beforeEach(() => {
    cy.visit('http://127.0.0.1:40137/')
  })

  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  })

  it("There is 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });
  
  it("Can add an item to cart", () => {
    cy.contains('Scented Blade').click()
    cy.contains('Add').click()
    cy.contains("My Cart (1)").should('exist')
  });
})