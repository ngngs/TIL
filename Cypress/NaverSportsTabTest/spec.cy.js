describe('네이버 사이트 테스트 시트', () => {
  it('네이버 사이트 방문', () => {
    cy.visit('https://www.naver.com');
  })

  it('네이버 검색 테스트', () => {
    cy.visit('https://www.naver.com');
    cy.get('input[name="query"]').type('e2e');
    cy.get('.btn_search').click();
  })
})
