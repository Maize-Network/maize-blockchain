const maize = require('../../util/maize');

describe('maize', () => {
  it('converts number mojo to maize', () => {
    const result = maize.mojo_to_maize(1000000);

    expect(result).toBe(0.000001);
  });
  it('converts string mojo to maize', () => {
    const result = maize.mojo_to_maize('1000000');

    expect(result).toBe(0.000001);
  });
  it('converts number mojo to maize string', () => {
    const result = maize.mojo_to_maize_string(1000000);

    expect(result).toBe('0.000001');
  });
  it('converts string mojo to maize string', () => {
    const result = maize.mojo_to_maize_string('1000000');

    expect(result).toBe('0.000001');
  });
  it('converts number maize to mojo', () => {
    const result = maize.maize_to_mojo(0.000001);

    expect(result).toBe(1000000);
  });
  it('converts string maize to mojo', () => {
    const result = maize.maize_to_mojo('0.000001');

    expect(result).toBe(1000000);
  });
  it('converts number mojo to colouredcoin', () => {
    const result = maize.mojo_to_colouredcoin(1000000);

    expect(result).toBe(1000);
  });
  it('converts string mojo to colouredcoin', () => {
    const result = maize.mojo_to_colouredcoin('1000000');

    expect(result).toBe(1000);
  });
  it('converts number mojo to colouredcoin string', () => {
    const result = maize.mojo_to_colouredcoin_string(1000000);

    expect(result).toBe('1,000');
  });
  it('converts string mojo to colouredcoin string', () => {
    const result = maize.mojo_to_colouredcoin_string('1000000');

    expect(result).toBe('1,000');
  });
  it('converts number colouredcoin to mojo', () => {
    const result = maize.colouredcoin_to_mojo(1000);

    expect(result).toBe(1000000);
  });
  it('converts string colouredcoin to mojo', () => {
    const result = maize.colouredcoin_to_mojo('1000');

    expect(result).toBe(1000000);
  });
});
