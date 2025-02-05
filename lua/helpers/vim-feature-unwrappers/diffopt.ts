export type DiffOptConfig = {
  lineMatch?: number,
  internal?: boolean
  filler?: boolean,
  closeoff?: boolean,
  algorithm?: 'histogram',
  indentHeuristic?: boolean
};
export function createDiffOptString(config: DiffOptConfig) {
  let result = "";

  const addSection = (section: string) => {
    if (result.length < 1) {
      result = section;
    }
    else {
      result += `,${section}`;
    }
  };

  if (config.lineMatch) {
    addSection(`linematch:${config.lineMatch}`);
  }

  if (config.internal) {
    addSection(`internal`);
  }

  if (config.filler) {
    addSection('filler');
  }

  if (config.closeoff) {
    addSection('closeoff');
  }

  if (config.indentHeuristic) {
    addSection('indent-heuristic');
  }

  if (config.)





    return result;
}
